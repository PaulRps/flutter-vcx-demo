//
// Created by Paulo Silva on 09/09/22.
//

import Foundation
import Combine
import SwiftyJSON

class PresentProofRequestUsecase {
    private final let logger = CustomLogger(context: PresentProofRequestUsecase.self)
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

    func presentProof(pairwiseDid: String?, sourceId: String?) -> AnyPublisher<NativeToFlutterResponseDto, Error> {
        Deferred {
            Future { promise in
                if !self.isParamsOk(pairwiseDid: pairwiseDid, sourceId: sourceId) {
                    promise(.failure(CustomError(errorMessage: .INTERNAL_ERROR)))
                    return
                }

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
                        .map { credentialsForProof in
                            self.parseCredential(credentialsForProof)
                        }
                        .flatMap({ parsedCredentials in
                            self.proofRepository.generateProof(
                                    proofHandle: proofHandle,
                                    selectedCredentials: parsedCredentials,
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
                            AriesStateUpdateAttempter().tryUpdateState(
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

    private func parseCredential(_ matchingCredentials: String) -> String {
        logger.info(message: "parsing matching credential on proof: \(matchingCredentials)")

        var jsonProofCredentials = try! JSON(data: matchingCredentials.data(using: .utf8)!)

        for (key, _): (String, JSON) in jsonProofCredentials["attrs"] {
            let selectedCredential = jsonProofCredentials["attrs"][key][0]
            jsonProofCredentials["attrs"][key] = ["credential": selectedCredential]
        }

        return jsonProofCredentials.rawString()!
    }

    private func releaseHandles(proofHandle: NSNumber, connectionHandle: NSNumber) {
        _ = proofRepository.releaseHandle(handle: proofHandle)
        _ = connectionRepository.releaseHandle(handle: connectionHandle)
    }

    private func isParamsOk(pairwiseDid: String?, sourceId: String?) -> Bool {
        pairwiseDid != nil && pairwiseDid?.isEmpty == false &&
                sourceId != nil && sourceId?.isEmpty == false
    }

    private func getProofRequest(fromProofRequests: String) -> String {
        let proofs = JsonUtil.toType(fromProofRequests, Array<[String: AnyObject]>.self)
        return JsonUtil.toJson(proofs?[0])
    }
}
