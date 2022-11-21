//
// Created by Paulo Silva on 03/11/22.
//

import Foundation
import Combine

class InviterCreateConnectionInvitationUseCase {
    private final let logger = CustomLogger(context: InviterCreateConnectionInvitationUseCase.self)
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
                        .sink(receiveCompletion: { completion in
                            switch completion {
                            case .finished: break
                            case .failure(let error):
                                promise(.failure(error))
                            }
                        }, receiveValue: { _ in
                            promise(.success(
                                    CreateConnectionInvitationResponseDto(
                                            invitation: invitation,
                                            connectionHandle: connectionHandle.stringValue
                                    )
                            ))
                        })
                        .store(in: &self.cancellables)
            })
        }
                .eraseToAnyPublisher()
    }


}
