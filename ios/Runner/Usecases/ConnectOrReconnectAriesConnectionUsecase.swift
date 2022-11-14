//
//  CreateOrRecreateAriesConnectionUsecase.swift
//  Runner
//
//  Created by Paulo Silva on 27/08/22.
//

import Foundation
import Combine

class ConnectOrReconnectAriesConnectionUsecase {
    private final let logger = CustomLogger(context: ConnectOrReconnectAriesConnectionUsecase.self)
    private final let connectionRepository: AriesConnectionRepository
    private final let createariesConnectionUsecase: CreateAriesConnectionUsecase
    private final var cancellables: Set<AnyCancellable>

    init(
            connectionRepository: AriesConnectionRepository = AriesConnectionRepository()
    ) {
        cancellables = Set()
        self.connectionRepository = connectionRepository
        createariesConnectionUsecase = CreateAriesConnectionUsecase(connectionRepository: connectionRepository)
    }

    func connect(invitation: ConnectionInvitationDto?, inviteId: String?) -> AnyPublisher<NativeToFlutterResponseDto, Error> {
        Deferred {
            Future { promise in
                self.logger.info(message: "checking if aries connection with \(invitation?.label) exists")
                self.connectionRepository.searchConnection(invitation: invitation!)
                        .map { isReconnection in
                            isReconnection
                        }
                        .flatMap({ (record: SearchRecordDto?) -> Future<String, Error> in
                            self.isReconnection(record) ?
                                    self.reconnect(invitation!, inviteId!, record!.id!) :
                                    self.createariesConnectionUsecase.connect(
                                            invitation: invitation!,
                                            inviteId: inviteId!
                                    )
                        })
                        .flatMap({ connectionJson in
                            self.connectionRepository.saveSerializedConnection(
                                    connectionJson,
                                    ConnectionTagsDto.from(invitation: invitation!, serializedConnection: connectionJson)
                            )
                        })
                        .sink(receiveCompletion: { completion in
                            switch completion {
                            case .finished: break
                            case .failure(let error):
                                self.logger.error(message: "error on creating aries connection: \(error.localizedDescription)")
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
        }
                .eraseToAnyPublisher()
    }

    private func isReconnection(_ connectionRecord: SearchRecordDto?) -> Bool {
        connectionRecord != nil && AriesConnectionUtil.isConnectionFinished(connection: connectionRecord)
    }

    private func reconnect(
            _ invitation: ConnectionInvitationDto,
            _ inviteId: String,
            _ connectionId: String
    ) -> Future<String, Error> {
        Future { promise in
            self.connectionRepository.deleteConnection(id: connectionId).map { _ in
                        self.logger.info(message: "deleted previous aries connection")
                    }
                    .flatMap({
                        self.createariesConnectionUsecase.connect(invitation: invitation, inviteId: inviteId)
                    })
                    .sink(receiveCompletion: { completion in
                        switch completion {
                        case .finished: break
                        case .failure(let error):
                            self.logger.error(message: "error on aries reconnection")
                            promise(.failure(error))
                        }
                    }, receiveValue: { serializedConnection in
                        self.logger.info(message: "reconnected successfully")
                        promise(.success(serializedConnection))
                    })
                    .store(in: &self.cancellables)
        }
    }
}
