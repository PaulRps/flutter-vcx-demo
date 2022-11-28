//
// Created by Paulo Pereira on 11/11/22.
//

import Foundation
import Combine

class VerifierRequestPresentProofUseCase {
    private final let logger = CustomLogger(context: VerifierRequestPresentProofUseCase.self)
    private final var cancellables: Set<AnyCancellable>
    private final let connectionRepository: AriesConnectionRepository
    private final let proofRepository: AriesProofRepository
    private final let extractProofDataUseCase: ExtractProverPresentedProofDataUseCase

    init(
            connectionRepository: AriesConnectionRepository = AriesConnectionRepository(),
            proofRepository: AriesProofRepository = AriesProofRepository(),
            extractProofDataUseCase: ExtractProverPresentedProofDataUseCase = ExtractProverPresentedProofDataUseCase()
    ) {
        self.connectionRepository = connectionRepository
        self.proofRepository = proofRepository
        self.extractProofDataUseCase = extractProofDataUseCase
        cancellables = Set()
    }

    func sendRequest(
            sourceId: String?,
            pairwiseDid: String?,
            proofName: String?,
            requestedAttributes: [RequestedProofAttribute]?
    ) -> AnyPublisher<NativeToFlutterResponseDto, Error> {
        Deferred {
            Future { promise in
                var connectionHandle: NSNumber = -1
                var proofHandle: NSNumber = -1

                self.connectionRepository.getConnectionHandleByPwDid(pairwiseDid: pairwiseDid!)
                        .map { handle in
                            connectionHandle = handle
                        }
                        .flatMap({ _ in
                            self.proofRepository.verifierCreateProofRequest(
                                    proofRequestData: self.buildProofRequest(
                                            sourceId: sourceId!,
                                            proofName: proofName!,
                                            requestedAttributes: requestedAttributes!
                                    )
                            )
                        })
                        .map { proHandle in
                            proofHandle = proHandle
                        }
                        .flatMap({ _ in
                            self.proofRepository.verifierSendProofRequest(
                                    proofHandle: proofHandle,
                                    connectionHandle: connectionHandle
                            )
                        })
                        .flatMap({ _ in
                            AriesPoller(tryLimit: 100, interval: 10).tryUpdateState(
                                    method: {
                                        self.proofRepository.verifierUpdateProofState(
                                                proofHandle: proofHandle,
                                                connectionHandle: connectionHandle
                                        )
                                    },
                                    logger: self.logger
                            )
                        })
                        .flatMap({ _ in
                            self.proofRepository.verifierGetPresentedProofMessage(proofHandle: proofHandle)
                        })
                        .sink(receiveCompletion: { completion in
                            switch completion {
                            case .finished: break
                            case .failure(let error):
                                promise(.failure(error))
                            }
                        }, receiveValue: { presentedProof in
                            let response = self.buildResponse(presentedProof: presentedProof)
                            promise(.success(response))
                        })
                        .store(in: &self.cancellables)
            }
        }
                .eraseToAnyPublisher()
    }

    private func buildResponse(
            presentedProof: (state: AriesFinishedState, msg: String)
    ) -> NativeToFlutterResponseDto {
        let proofData = extractProofDataUseCase.extract(presentedProofJson: presentedProof.msg)
        return PresentedProofResponseDto(
                success: presentedProof.state.isFinished(),
                revealedAttributes: proofData.revealedAttrs,
                selfAttestAttributes: proofData.selfAttestedAttrs
        )
    }

    private func buildProofRequest(
            sourceId: String,
            proofName: String,
            requestedAttributes: [RequestedProofAttribute]
    ) -> ProofRequestDto {
        ProofRequestDto(
                sourceId: sourceId,
                attributes: requestedAttributes.map { e -> ProofRequestedAttributeDto in
                    ProofRequestedAttributeDto(
                            restrictions: [
                                ProofAttributeRestrictionDto(
                                        schemaName: e.schemaName,
                                        schemaVersion: e.schemaVersion
                                )
                            ],
                            name: e.name
                    )
                },
                predicates: [/*ProofPredicateDto(
                        name: "registro_geral",
                        type: .GREATER,
                        value: 0,
                        restrictions: [ProofAttributeRestrictionDto(schemaId: "SVQyyeuVQHidY9SmNSS3Dc:2:rg-schema:1.0")]
                )*/],
                name: proofName,
                revocationInterval: ProofRequestRevocationIntervalDto(
                        to: (Date().timeIntervalSince1970 * 1000.0).rounded()
                )
        )
    }

}
