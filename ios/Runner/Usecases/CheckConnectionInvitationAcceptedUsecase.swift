//
// Created by Paulo Silva on 10/11/22.
//

import Foundation
import Combine

class CheckConnectionInvitationAcceptedUsecase {
    private final let logger = CustomLogger(context: CheckConnectionInvitationAcceptedUsecase.self)
    private final var cancellables: Set<AnyCancellable>
    private final let connectionRepository: AriesConnectionRepository

    init(
            connectionRepository: AriesConnectionRepository = AriesConnectionRepository()
    ) {
        self.connectionRepository = connectionRepository
        cancellables = Set()
    }

    func checkAndSaveConnection(connectionHandle: NSNumber?) -> AnyPublisher<NativeToFlutterResponseDto, Error> {
        Deferred {
            Future { promise in
                AriesStateUpdatePoller(tryLimit: 10, interval: 5).tryUpdateState(
                                method: {
                                    self.connectionRepository.updateConnectionState(connectionHandle: connectionHandle!)
                                },
                                logger: self.logger
                        )
                        .sink(receiveCompletion: { completion in
                            switch completion {
                            case .finished: break
                            case .failure(let error):
                                promise(.failure(error))
                            }
                        }, receiveValue: { wasAccepted in
                            if !wasAccepted {
                                promise(.success(NativeToFlutterResponseDto(success: wasAccepted)))
                                return
                            }

                            self.saveConnection(connectionHandle: connectionHandle!, promise: promise)
                        })
                        .store(in: &self.cancellables)
            }
        }
                .eraseToAnyPublisher()
    }

    private func saveConnection(connectionHandle: NSNumber, promise: @escaping (Result<NativeToFlutterResponseDto, Error>) -> ()) {
        var connectionJson = ""
        connectionRepository.getSerializedConnection(connectionHandle: connectionHandle)
                .map { serializedConnection in
                    connectionJson = serializedConnection
                }
                .flatMap({ _ in
                    //TODO: must check connection already exists
                    self.connectionRepository.saveSerializedConnection(
                            connectionJson,
                            self.buildConnectionTags(serializedConnection: connectionJson)
                    )
                })
                .sink(receiveCompletion: { completion in
                    _ = self.connectionRepository.releaseHandle(connectionHandle: connectionHandle)
                    switch completion {
                    case .finished: break
                    case .failure(let error):
                        self.logger.error(message: "error on saving aries connection: \(error.localizedDescription)")
                        promise(.failure(error))
                    }
                }, receiveValue: { connectionRecord in
                    let tags = JsonUtil.fromJson(connectionRecord?.tag ?? "", ConnectionTagsDto.self)
                    promise(.success(
                            CreateAriesConnectionResponseDto(
                                    pairwiseDid: tags?.myDid,
                                    connectionName: tags?.theirLabel,
                                    success: true
                            )
                    ))
                })
                .store(in: &self.cancellables)
    }

    private func buildConnectionTags(serializedConnection: String) -> ConnectionTagsDto {
        ConnectionTagsDto(
                state: ConnectionStateEnum.FINISHED.value,
                requestId: nil,
                theirLabel: nil,
                theirVerkey: nil,
                invitationKey: nil,
                imageUrl: nil,
                image_url: nil,
                serviceEndpoint: nil
        )
    }
}
