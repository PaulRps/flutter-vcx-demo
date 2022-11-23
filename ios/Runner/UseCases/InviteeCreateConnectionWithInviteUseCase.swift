//
//  CreateAriesConnectionUseCase.swift
//  Runner
//
//  Created by Paulo Silva on 27/08/22.
//

import Foundation
import Combine

class InviteeCreateConnectionWithInviteUseCase {
    private final let connectionRepository: AriesConnectionRepository
    private final let logger = CustomLogger(context: InviteeCreateConnectionWithInviteUseCase.self)
    private final var cancellables: Set<AnyCancellable>

    init(
            connectionRepository: AriesConnectionRepository
    ) {
        self.connectionRepository = connectionRepository
        cancellables = Set()
    }

    func connect(invitation: ConnectionInvitationDto, sourceId: String) -> Future<String, Error> {
        Future { promise in
            self.logger.info(message: "creating aries connection")
            var connectionHandle: NSNumber = 0
            var serializedConnection = ""
            self.connectionRepository.connectionCreateWithInvite(
                            invitation: invitation,
                            sourceId: sourceId
                    ).map { handle in
                        connectionHandle = handle
                    }
                    .flatMap({
                        self.connectionRepository.connectionConnect(
                                connectionHandle: connectionHandle,
                                connectionOptions: ConnectionOptionsDto(usePublicDid: true)
                        )
                    })
                    .flatMap({ _ in
                        AriesPoller().tryUpdateState(
                                method: {
                                    self.connectionRepository.updateConnectionState(connectionHandle: connectionHandle)
                                },
                                logger: self.logger
                        )
                    })
                    .flatMap({ _ in
                        self.connectionRepository.getSerializedConnection(connectionHandle: connectionHandle)
                    })
                    .map { connection in
                        serializedConnection = connection
                    }
                    .sink(receiveCompletion: { completion in
                        _ = self.connectionRepository.releaseHandle(connectionHandle: connectionHandle)
                        switch completion {
                        case .finished: break
                        case .failure(let error):
                            _ = self.connectionRepository.releaseHandle(handle: connectionHandle)
                            promise(.failure(error))
                        }
                    }, receiveValue: { _ in
                        promise(.success(serializedConnection))
                    })
                    .store(in: &self.cancellables)
        }
    }
}
