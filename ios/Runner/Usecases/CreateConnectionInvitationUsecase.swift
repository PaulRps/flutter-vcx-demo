//
// Created by Paulo Silva on 03/11/22.
//

import Foundation
import Combine

class CreateConnectionInvitationUsecase {
    private final let logger = CustomLogger(context: CreateConnectionInvitationUsecase.self)
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

    func createInvitation() -> AnyPublisher<NativeToFlutterResponseDto, Error> {
        Deferred {
            Future({ promise in
                var connectionHandle: NSNumber = -1
                var proofHandle: NSNumber = -1
                var invitation = ""
                var presentedProofMsg = ""

//                let proofRequestData = self.buildProofRequest()
//                JsonUtil.toJson(codable: proofRequestData.attributes)
//                JsonUtil.toJson(codable: proofRequestData.predicates)
//                proofRequestData.revocationInterval.toJson()
                self.connectionRepository.createConnection(withSourceId: "test")
                        .map { connHandle in
                            connectionHandle = connHandle
                        }
                        .flatMap({ _ in
                            self.connectionRepository.connectionConnect(
                                    connectionHandle: connectionHandle,
                                    connectionOptions: ConnectionOptionsDto()
                            )
                        })
                        .flatMap({ _ in
                            self.connectionRepository.getConnectionInvitationDetails(connectionHandle: connectionHandle)
                        })
                        .map { invite in
                            invitation = invite
                        }
                        .flatMap({ _ in
                            AriesStateUpdatePoller(tryLimit: 100, interval: 5).tryUpdateState(
                                    method: {
                                        self.connectionRepository.updateConnectionState(connectionHandle: connectionHandle)
                                    },
                                    logger: self.logger
                            )
                        })
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
                            _ = self.connectionRepository.releaseHandle(connectionHandle: connectionHandle)
                            switch completion {
                            case .finished: break
                            case .failure(let error):
                                promise(.failure(error))
                            }
                        }, receiveValue: { _ in
                            promise(.success(CreateConnectionInvitationResponseDto(invitation: invitation)))
                        })
                        .store(in: &self.cancellables)
            })
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
