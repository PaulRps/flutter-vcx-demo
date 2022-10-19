//
// Created by Paulo Silva on 18/10/22.
//

import Foundation
import Combine

class RejectProofRequestUsecase {
    private final let logger = CustomLogger(context: RejectProofRequestUsecase.self)
    private final var cancellables: Set<AnyCancellable>
    private final let proofRepository: AriesProofRepository
    private final let connectionRepository: AriesConnectionRepository
    private final let agencyRepository: AriesAgencyRepository

    init(
            proofRepository: AriesProofRepository = AriesProofRepository(),
            connectionRepository: AriesConnectionRepository = AriesConnectionRepository(),
            agencyRepository: AriesAgencyRepository = AriesAgencyRepository()
    ) {
        cancellables = Set()
        self.proofRepository = proofRepository
        self.connectionRepository = connectionRepository
        self.agencyRepository = agencyRepository
    }

    func reject(proofMsg: String?, sourceId: String?) -> AnyPublisher<NativeToFlutterResponseDto, Error> {
        Deferred {
            Future { promise in
                var loginMap = JsonUtil.toDictionary(proofMsg!)
                let verifier = loginMap?["~service"] as? [String: Any]
                loginMap?.removeValue(forKey: "~service")
                let serviceEndpoint = verifier?["serviceEndpoint"] as? String
                let proofRequest = JsonUtil.toJson(loginMap)

                var connectionHandle: NSNumber = 0
                var proofHandle: NSNumber = 0
                self.connectionRepository.searchConnection(query: ["serviceEndpoint", serviceEndpoint!])
                        .map { searchResponse in
                            searchResponse?.value
                        }
                        .flatMap({ connectionJson in
                            self.connectionRepository.getConnectionHandle(serializedConnection: connectionJson!)
                        })
                        .map({ handle in
                            connectionHandle = handle
                        })
                        .flatMap({ _ in
                            self.proofRepository.createProof(withRequest: proofRequest, sourceId: sourceId!)
                        })
                        .map { handle in
                            proofHandle = handle
                        }
//                        .flatMap({ _ in
//                            self.proofRepository.rejectProofRequest(proofHandle: proofHandle, connectionHandle: connectionHandle)
//                        })
                        .flatMap({ _ in
                            self.proofRepository.declineProofRequest(
                                    proofHandle: proofHandle,
                                    connectionHandle: connectionHandle,
                                    reason: "i can not agree with the requested fields"
                            )
                        })
                        .sink(receiveCompletion: { completion in
                            self.releaseHandles(proofHandle: proofHandle, connectionHandle: connectionHandle)
                            switch completion {
                            case .finished: break
                            case .failure(let error):
                                self.logger.error(message: "error on rejecting aries proof request: \(error.localizedDescription)")
                                promise(.failure(error))
                            }
                        }, receiveValue: { success in
                            self.logger.info(message: "finished reject proof request success=\(success)")

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
}
