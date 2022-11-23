//
// Created by Paulo Silva on 05/09/22.
//

import Foundation
import Combine
import vcx

class AriesCredentialAdapter: CredentialPort, CheckVcxResult {
    private final let logger = CustomLogger(context: AriesCredentialAdapter.self)
    private final let vcx: VcxAPI

    init() {
        vcx = VcxAPI()
    }

    func getOffers(connectionHandle: NSNumber) -> Future<String, Error> {
        Future { promise in
            self.logger.info(message: "getting credential offers")
            self.vcx.credentialGetOffers(
                    connectionHandle.uintValue
            ) { error, offers in
                if self.isFail(error) {
                    self.logger.error(message: "error on getting aries credential offer: \(error!.localizedDescription)")
                    promise(.failure(error!))
                    return
                }

                self.logger.info(message: "finished get credential offers with result=\(offers!)")
                promise(.success(offers!))
            }
        }
    }

    func createCredential(withOffer: String, sourceId: String) -> Future<NSNumber, Error> {
        Future { promise in
            self.logger.info(message: "creating credential with offer=\(withOffer)")
            self.vcx.credentialCreate(withOffer: sourceId, offer: withOffer) { error, credentialHandle in
                if self.isFail(error) {
                    self.logger.error(message: "error on creating credential with offer: \(error!.localizedDescription)")
                    promise(.failure(error!))
                    return
                }

                self.logger.info(message: "finished creating credential offer")
                promise(.success(credentialHandle as NSNumber))
            }
        }
    }

    func sendRequest(
            credentialHandle: NSNumber,
            connectionHandle: NSNumber,
            paymentHandle: NSNumber
    ) -> Future<NSNumber, Error> {
        Future { promise in
            self.logger.info(message: "sending credential request")
            self.vcx.credentialSendRequest(
                    credentialHandle.uintValue,
                    connectionHandle: connectionHandle.uintValue,
                    paymentHandle: paymentHandle.uintValue
            ) { error in
                if self.isFail(error) {
                    self.logger.error(message: "error on sending credential request: \(error!.localizedDescription)")
                    promise(.failure(error!))
                    return
                }

                self.logger.info(message: "sent credential request successfully")
                promise(.success(0))
            }

        }
    }

    func getSerializedCredential(credentialHandle: NSNumber) -> Future<String, Error> {
        Future { promise in
            self.vcx.credentialSerialize(credentialHandle.uintValue) { error, credentialJson in
                if self.isFail(error) {
                    self.logger.error(message: "error on getting serialized credential: \(error!.localizedDescription)")
                    promise(.failure(error!))
                    return
                }

                self.logger.info(message: "get serialized credential successfully")
                promise(.success(credentialJson!))
            }
        }
    }

    func releaseHandle(handle: NSNumber?) -> NSNumber {
        if handle == nil {
            logger.error(message: "credential handle is null")
            return -1
        }

        logger.info(message: "releasing credential handle")
        return vcx.credentialRelease(handle!.uintValue) as NSNumber
    }

    func updateState(
            credentialHandle: NSNumber,
            connectionHandle: NSNumber
    ) -> Future<AriesFinishedState, Error> {
        Future { promise in
            self.vcx.credentialUpdateStateV2(
                    credentialHandle.uintValue,
                    connectionHandle: connectionHandle.uintValue
            ) { error, state in
                if self.isFail(error) {
                    self.logger.error(message: "error on updating credential state: \(error!.localizedDescription)")
                    promise(.failure(error!))
                    return
                }

                let connectionState = CredentialHolderStateEnum.getOne(id: state)
                self.logger.info(message: "finished updated credential [current state=\(connectionState)(id: \(state))]")

                promise(.success(AriesCredentialHolderFinishedState(state: connectionState)))
            }
        }
    }

}