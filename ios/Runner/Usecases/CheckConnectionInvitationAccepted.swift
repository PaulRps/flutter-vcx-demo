//
// Created by Paulo Silva on 10/11/22.
//

import Foundation
import Combine

class CheckConnectionInvitationAccepted {

    private final let logger = CustomLogger(context: CheckConnectionInvitationAccepted.self)
    private final var cancellables: Set<AnyCancellable>
    private final let connectionRepository: AriesConnectionRepository

    init(
            connectionRepository: AriesConnectionRepository = AriesConnectionRepository()
    ) {
        self.connectionRepository = connectionRepository
        cancellables = Set()
    }

    func checkAndSaveConnection(
        connectionHandle: NSNumber?,
        isToReleaseHandle: Bool?
    ) -> AnyPublisher<NativeToFlutterResponseDto, Error> {
        Deferred {
            Future { promise in
                self.connectionRepository.updateConnectionState(connectionHandle: connectionHandle!)
                        .sink(receiveCompletion: { completion in
                            switch completion {
                            case .finished: break
                            case .failure(let error):
                                promise(.failure(error))
                            }
                        }, receiveValue: { connectionState in
                            if !connectionState.isFinished() {
                                if isToReleaseHandle == true {
                                   _ = self.connectionRepository.releaseHandle(handle: connectionHandle)
                                }
                                
                                promise(.success(NativeToFlutterResponseDto(success: false)))
                                return
                            }

                            self.saveConnection(connectionHandle: connectionHandle!, promise: promise)
                        })
                        .store(in: &self.cancellables)
            }
        }
                .eraseToAnyPublisher()
    }

    private func saveConnection(
        connectionHandle: NSNumber,
        promise: @escaping (Result<NativeToFlutterResponseDto, Error>) -> ()
    ) {
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
       ConnectionTagsDto.from(serializedConnection: serializedConnection)
    }
}
