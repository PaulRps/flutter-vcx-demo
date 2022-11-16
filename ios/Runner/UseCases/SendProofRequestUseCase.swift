//
// Created by Paulo Pereira on 11/11/22.
//

import Foundation
import Combine

class SendProofRequestUseCase {
    private final let logger = CustomLogger(context: SendProofRequestUseCase.self)
    private final var cancellables: Set<AnyCancellable>
    private final let connectionRepository: AriesConnectionRepository
    private final let proofRepository: AriesProofRepository

    init(
            connectionRepository: AriesConnectionRepository = AriesConnectionRepository(),
            proofRepository: AriesProofRepository = AriesProofRepository()
    ) {
        self.connectionRepository = connectionRepository
        self.proofRepository = proofRepository
        cancellables = Set()
    }

    func sendRequest(pairwiseDid: String?) -> AnyPublisher<NativeToFlutterResponseDto, Error> {
        Deferred {
            Future { promise in
                var connectionHandle: NSNumber = -1
                var proofHandle: NSNumber = -1
                var presentedProofMsg = ""

                self.connectionRepository.getConnectionHandleByPwDid(pairwiseDid: pairwiseDid!)
                        .map { handle in
                            connectionHandle = handle
                        }
                        .flatMap({ _ in
                            self.proofRepository.verifierCreateProofRequest(
                                    proofRequestData: self.buildProofRequest()
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
                            AriesStateUpdatePoller(tryLimit: 100, interval: 5).tryUpdateState(
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
                        .map { proofMsg in
                            presentedProofMsg = proofMsg.msg
                        }
                        .sink(receiveCompletion: { completion in
                            switch completion {
                            case .finished: break
                            case .failure(let error):
                                promise(.failure(error))
                            }
                        }, receiveValue: { _ in
                            promise(.success(NativeToFlutterResponseDto(success: true)))
                        })
                        .store(in: &self.cancellables)
            }
        }
                .eraseToAnyPublisher()
    }

    private func buildProofRequest() -> ProofRequestDto {
        ProofRequestDto(
                sourceId: "test",
                attributes: [
                    ProofRequestedAttributeDto(
                            restrictions: [
                                ProofAttributeRestrictionDto(schemaId: "FJ5sv2U8xaWbYEat1eK3ES:2:cnh-schema:3.8")
                            ],
                            name: "cpf"
                    )
                ],
                predicates: [],
                name: "cnh-proof",
                revocationInterval: ProofRequestRevocationIntervalDto(
                        to: (Date().timeIntervalSince1970 * 1000.0).rounded()
                )
        )
    }
}
