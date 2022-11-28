//
// Created by Paulo Silva on 09/09/22.
//

import Foundation
import Combine
import vcx

class AriesProofAdapter: ProofPort, CheckVcxResult {

    private final let logger = CustomLogger(context: AriesProofAdapter.self)
    private final let vcx: VcxAPI

    init() {
        vcx = VcxAPI()
    }

    func getProofRequests(connectionHandle: NSNumber) -> Future<String, Error> {
        Future { promise in
            self.logger.info(message: "getting aries proof requests")
            self.vcx.proofGetRequests(
                    connectionHandle
            ) { error, requestsJson in
                if self.isFail(error) {
                    self.logger.error(message: "error on getting proof requests: \(error!.localizedDescription)")
                    promise(.failure(error!))
                    return
                }

                self.logger.info(message: "finished get aries proof requests")
                self.logger.debug(message: "aries proof requests: \(requestsJson!)")
                promise(.success(requestsJson!))
            }
        }
    }

    func createProof(withRequest: String, sourceId: String) -> Future<NSNumber, Error> {
        Future { promise in
            self.logger.info(message: "creating aries proof with request")
            self.vcx.proofCreate(
                    withRequest: sourceId,
                    withProofRequest: withRequest
            ) { error, proofHandle in
                if self.isFail(error) {
                    self.logger.error(message: "error on creating proof with request: \(error!.localizedDescription)")
                    promise(.failure(error!))
                    return
                }

                self.logger.info(message: "created proof with request successfully")
                self.logger.debug(message: "proof handle: \(proofHandle)")

                promise(.success(proofHandle!))
            }
        }
    }

    func getCredentialsProof(proofHandle: NSNumber) -> Future<String, Error> {
        Future { promise in
            self.logger.info(message: "getting aries credentials for proof")
            self.vcx.proofRetrieveCredentials(
                    proofHandle
            ) { error, matchingCredentials in
                if self.isFail(error) {
                    self.logger.error(
                            message: "error on getting aries credentials for proof: \(error!.localizedDescription)"
                    )
                    promise(.failure(error!))
                    return
                }

                self.logger.info(message: "got aries credentials for proof successfully")
                promise(.success(matchingCredentials!))
            }
        }
    }

    func generateProof(
            proofHandle: NSNumber,
            selectedCredentials: String,
            selfAttestedAtt: String
    ) -> Future<NSNumber, Error> {
        Future { promise in
            self.logger.info(message: "generating aries proof")
            self.vcx.proofGenerate(
                    proofHandle,
                    withSelectedCredentials: selectedCredentials,
                    withSelfAttestedAttrs: selfAttestedAtt
            ) { error in
                if self.isFail(error) {
                    self.logger.error(message: "error on generating aries proof: \(error!.localizedDescription)")
                    promise(.failure(error!))
                    return
                }

                self.logger.info(message: "generated aries proof successfully")
                promise(.success(0))
            }
        }
    }

    func sendProof(proofHandle: NSNumber, connectionHandle: NSNumber) -> Future<NSNumber, Error> {
        Future { promise in
            self.logger.info(message: "sending aries proof")
            self.vcx.proofSend(
                    proofHandle,
                    withConnectionHandle: connectionHandle
            ) { error in
                if self.isFail(error) {
                    self.logger.error(message: "error sending aries proof: \(error!.localizedDescription)")
                    promise(.failure(error!))
                    return
                }

                self.logger.info(message: "sent aries proof successfully")
                promise(.success(0))
            }
        }
    }

    func releaseHandle(proofHandle: NSNumber?) -> NSNumber {
        if proofHandle == nil {
            logger.error(message: "proof handle is null")
            return -1
        }

        return NSNumber(value: vcx.proofRelease(proofHandle!))
    }

    func updateState(proofHandle: NSNumber, connectionHandle: NSNumber) -> Future<AriesFinishedState, Error> {
        Future { promise in
            self.logger.info(message: "updating aries proof state")
            self.vcx.proofUpdateStateV2(
                    proofHandle,
                    connectionHandle: connectionHandle
            ) { error, state in
                if self.isFail(error) {
                    self.logger.error(message: "error on updating aries proof state: \(error!.localizedDescription)")
                    promise(.failure(error!))
                    return
                }

                let proofState = ProofProverStateEnum.getOne(id: state!.uintValue)
                self.logger.info(message: "finished updated credential [current state=\(proofState)]")

                promise(.success(AriesProofProverFinishedState(state: proofState)))
            }
        }
    }

    func getSerializedProof(proofHandle: NSNumber) -> Future<String, Error> {
        Future { promise in
            self.logger.info(message: "getting aries serialized proof")
            self.vcx.proofSerialize(
                    proofHandle
            ) { error, proofJson in
                if self.isFail(error) {
                    self.logger.error(message: "error on getting aries serialized proof:\(error!.localizedDescription)")
                    promise(.failure(error!))
                    return
                }
                self.logger.info(message: "got aries serialized proof successfully")
                self.logger.debug(message: "aries serialized proof: \(proofJson!)")
                promise(.success(proofJson!))
            }
        }
    }

    func rejectProofRequest(proofHandle: NSNumber, connectionHandle: NSNumber) -> Future<Bool, Error> {
        Future { promise in
            self.logger.info(message: "rejecting aries proof request")
            self.vcx.proofReject(
                    proofHandle,
                    withConnectionHandle: connectionHandle
            ) { error in
                if self.isFail(error) {
                    self.logger.error(message: "error on rejecting aries proof request:\(error!.localizedDescription)")
                    promise(.failure(error!))
                    return
                }
                self.logger.info(message: "rejected proof request successfully")
                promise(.success(true))
            }
        }
    }

    func declineProofRequest(
            proofHandle: NSNumber,
            connectionHandle: NSNumber,
            reason: String?,
            proposal: String?
    ) -> Future<Bool, Error> {
        Future { promise in
            self.logger.info(message: "declining aries proof request")
            self.logger.info(message: "reason: \(reason) proposal: \(proposal)")
            self.vcx.proofDeclinePresentationRequest(
                    proofHandle,
                    connectionHandle: connectionHandle,
                    reason: reason,
                    proposal: proposal
            ) { error in
                if self.isFail(error) {
                    self.logger.error(message: "error on declining aries proof request:\(error!.localizedDescription)")
                    promise(.failure(error!))
                    return
                }
                self.logger.info(message: "declined proof request successfully")
                promise(.success(true))
            }
        }
    }

    func verifierCreateProof(
            sourceId: String,
            requestedAttributes: String,
            requestedPredicate: String,
            revocationInterval: String,
            proofName: String
    ) -> Future<NSNumber, Error> {
        Future { promise in
            self.logger.info(message: "creating proof request")
            self.vcx.verifierProofCreate(
                    sourceId,
                    requestedAttrs: requestedAttributes,
                    requestedPredicates: requestedPredicate,
                    revocationInterval: revocationInterval,
                    proofName: proofName
            ) { error, proofHandle in
                if self.isFail(error) {
                    self.logger.error(message: "error on creating aries proof request:\(error!.localizedDescription)")
                    promise(.failure(error!))
                    return
                }
                self.logger.info(message: "created proof request successfully")
                promise(.success(proofHandle!))
            }
        }

    }

    func verifierSendProofRequest(proofHandle: NSNumber, connectionHandle: NSNumber) -> Future<Bool, Error> {
        Future { promise in
            self.vcx.verifierProofSendRequest(
                    proofHandle,
                    connectionHandle: connectionHandle
            ) { error in
                if self.isFail(error) {
                    self.logger.error(message: "error on sending aries proof request:\(error!.localizedDescription)")
                    promise(.failure(error!))
                    return
                }
                self.logger.info(message: "sent proof request successfully")
                promise(.success(true))
            }
        }
    }

    func verifierUpdateStateV2(proofHandle: NSNumber, connectionHandle: NSNumber) -> Future<AriesFinishedState, Error> {
        Future { promise in
            self.logger.info(message: "verifier updating proof state")
            self.vcx.verifierProofUpdateStateV2(
                    proofHandle,
                    connectionHandle: connectionHandle
            ) { error, state in
                if self.isFail(error) {
                    self.logger.error(message: "error on updating aries proof request:\(error!.localizedDescription)")
                    promise(.failure(error!))
                    return
                }

                let proofState = ProofVerifierStateEnum.getOne(id: state!.uintValue)

                self.logger.info(message: "finished verifier updated proof state [current state=\(proofState)(id: \(state))]")

                promise(.success(AriesProofVerifierFinishedState(state: proofState)))
            }
        }
    }

    func verifierGetPresentedProofMessage(proofHandle: NSNumber) -> Future<(state: AriesFinishedState, msg: String), Error> {
        Future { promise in
            self.vcx.verifierGetProofMessage(proofHandle) { error, state, responseData in
                if self.isFail(error) {
                    self.logger.error(message: "error on getting aries proof message:\(error!.localizedDescription)")
                    promise(.failure(error!))
                    return
                }

                let proofState = AriesProofVerifierFinishedState(
                        state: ProofVerifierStateEnum.getOne(id: state!.uintValue)
                )

                self.logger.info(message: "got proof message successfully")
                self.logger.debug(message: "proof message: \(responseData)")

                promise(.success((state: proofState, msg: responseData!)))
            }
        }
    }
}
