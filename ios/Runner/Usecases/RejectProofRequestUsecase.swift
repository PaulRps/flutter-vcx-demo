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

    func reject(
            pairwiseDid: String?,
            sourceId: String?
    ) -> AnyPublisher<NativeToFlutterResponseDto, Error> {
        Deferred {
            Future { promise in

                var connectionHandle: NSNumber = 0
                var proofHandle: NSNumber = 0
                self.connectionRepository.getConnectionHandleByPwDid(pairwiseDid: pairwiseDid!)
                        .map({ handle in
                            connectionHandle = handle
                        })
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
                        }
                        .flatMap({ _ in
                            self.proofRepository.rejectProofRequest(proofHandle: proofHandle, connectionHandle: connectionHandle)
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

    private func getProofRequest(fromProofRequests: String) -> String {
        let proofs = JsonUtil.toType(fromProofRequests, Array<[String: AnyObject]>.self)
        return JsonUtil.toJson(proofs?[0])
    }

    private func releaseHandles(proofHandle: NSNumber, connectionHandle: NSNumber) {
        _ = proofRepository.releaseHandle(handle: proofHandle)
        _ = connectionRepository.releaseHandle(handle: connectionHandle)
    }
}
