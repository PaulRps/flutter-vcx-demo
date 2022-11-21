//
// Created by Paulo Silva on 09/09/22.
//

import Foundation
import Combine
import SwiftyJSON

class ProverPresentProofUseCase {
    private final let logger = CustomLogger(context: ProverPresentProofUseCase.self)
    private final var cancellables: Set<AnyCancellable>
    private final let proofRepository: AriesProofRepository
    private final let connectionRepository: AriesConnectionRepository
    private final let agencyRepository: AriesAgencyRepository
    private final let holderSelectCredentialsProofUseCase: HolderSelectCredentialsForProofUseCase

    init(
            proofRepository: AriesProofRepository = AriesProofRepository(),
            connectionRepository: AriesConnectionRepository = AriesConnectionRepository(),
            agencyRepository: AriesAgencyRepository = AriesAgencyRepository(),
            holderSelectCredentialsProofUseCase: HolderSelectCredentialsForProofUseCase = HolderSelectCredentialsForProofUseCase()
    ) {
        cancellables = Set()
        self.proofRepository = proofRepository
        self.connectionRepository = connectionRepository
        self.agencyRepository = agencyRepository
        self.holderSelectCredentialsProofUseCase = holderSelectCredentialsProofUseCase
    }

    func presentProof(pairwiseDid: String?, sourceId: String?) -> AnyPublisher<NativeToFlutterResponseDto, Error> {
        Deferred {
            Future { promise in
                self.logger.info(message: "presenting aries proof request")

                var connectionHandle: NSNumber = -1
                var proofHandle: NSNumber = -1
                self.connectionRepository.getConnectionHandleByPwDid(pairwiseDid: pairwiseDid!)
                        .map { handle in
                            connectionHandle = handle
                        }
                        .flatMap({ _ in
                            self.proofRepository.getProofRequests(connectionHandle: connectionHandle)
                        })
                        .map { proofRequests in
                            self.getProofRequest(fromProofRequests: proofRequests)
                        }
                        .flatMap({ proofRequest in
                            self.proofRepository.createProof(withRequest: proofRequest, sourceId: sourceId!)
                        })
                        .map { handle in
                            proofHandle = handle
//                            self.agencyRepository.updateMessageStatus(
//                                    newStaus: AgencyMessageStatusEnum.REVIEWED,
//                                    pairwiseDid: pairwiseDid!,
//                                    msgUids: []
//                            )
                        }
                        .flatMap({ _ in
                            self.proofRepository.getCredentialsForProof(proofHandle: proofHandle)
                        })
                        .map { matchingCredentials in
                            self.holderSelectCredentialsProofUseCase.select(matchingCredentials: matchingCredentials)
                        }
                        .flatMap({ credentialsForProof in
                            self.proofRepository.generateProof(
                                    proofHandle: proofHandle,
                                    selectedCredentials: credentialsForProof,
                                    selfAttestedAtt: "{}"
                            )
                        })
                        .flatMap({ _ in
                            self.proofRepository.sendProof(
                                    proofHandle: proofHandle,
                                    connectionHandle: connectionHandle
                            )
                        })
                        .flatMap({ _ in
                            AriesPoller().tryUpdateState(
                                    method: {
                                        self.proofRepository.updateProofState(
                                                proofHandle: proofHandle, connectionHandle: connectionHandle
                                        )
                                    },
                                    logger: self.logger
                            )
                        })
                        .flatMap({ _ in
                            self.proofRepository.getSerializedProof(proofHandle: proofHandle)
                        })
                        .sink(receiveCompletion: { completion in
                            self.releaseHandles(proofHandle: proofHandle, connectionHandle: connectionHandle)
                            switch completion {
                            case .finished: break
                            case .failure(let error):
                                self.logger.error(message: "error on presenting aries proof request: \(error.localizedDescription)")
                                promise(.failure(error))
                            }
                        }, receiveValue: { serializedProof in
                            let success = serializedProof.isEmpty == false

                            self.logger.info(message: "finished proof presentation success=\(success)")
                            self.logger.debug(message: "serialized proof: \(serializedProof)")

                            promise(.success(NativeToFlutterResponseDto(success: success)))
                        })
                        .store(in: &self.cancellables)

            }
        }
                .eraseToAnyPublisher()
    }

    private func releaseHandles(proofHandle: NSNumber, connectionHandle: NSNumber) {
        _ = proofRepository.releaseHandle(handle: proofHandle)
        _ = connectionRepository.releaseHandle(handle: connectionHandle)
    }

    private func getProofRequest(fromProofRequests: String) -> String {
        let proofs = (try? JSON(data: fromProofRequests.data(using: .utf8) ?? Data())) ?? JSON([])
        return proofs.array?[0].rawString() ?? ""
    }
}
