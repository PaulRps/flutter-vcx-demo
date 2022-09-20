//
//  AriesConnectionAdapter.swift
//  Runner
//
//  Created by Paulo Silva on 26/08/22.
//

import Foundation
import Combine
import vcx

class AriesConnectionAdapter: ConnectionPort, CheckVcxResult {

    private final let logger = CustomLogger(context: AriesConnectionAdapter.self)
    private final let vcx: ConnectMeVcx

    init() {
        vcx = ConnectMeVcx()
    }

    func updateState(connectionHandle: NSNumber) -> Future<AriesFinishedState, Error> {
        Future { promise in
            self.logger.info(message: "updating connection state")
            self.vcx.connectionUpdateState(
                    Int(truncating: connectionHandle)) { error, state in
                if self.isFail(error) {
                    self.logger.error(message: "error on updating connection state: \(error!.localizedDescription)")
                    promise(.failure(error!))
                    return
                }

                let connectionState = ConnectionStateEnum.getOne(id: state)
                self.logger.info(message: "finished updated connection [current state=\(connectionState)]")

                promise(.success(AriesConnectionFinishedState(state: connectionState)))
            }
        }
    }

    func getSerializedConnection(connectionHandle: NSNumber) -> Future<String, Error> {
        Future { promise in
            self.logger.info(message: "getting serialized connection")
            self.vcx.connectionSerialize(connectionHandle.intValue) { error, connectionJson in
                if self.isFail(error) || connectionJson?.isEmpty == true {
                    self.logger.error(message: "error on getting serialized connection: \(error!.localizedDescription)")
                    promise(.failure(error!))
                    return
                }
                self.logger.info(message: "got serialized connection successfully")
                promise(.success(connectionJson!))
            }
        }
    }

    func getConnectionHandle(serializedConnection: String?) -> Future<NSNumber, Error> {
        Future { promise in
            if serializedConnection == nil || serializedConnection?.isEmpty == true {
                promise(.failure(CustomError(errorMessage: .INTERNAL_ERROR)))
                return
            }

            self.vcx.connectionDeserialize(
                    serializedConnection!) { error, handle in
                if self.isFail(error) {
                    self.logger.error(message: "error on getting connection handle: \(error!.localizedDescription)")
                    promise(.failure(error!))
                    return
                }
                self.logger.info(message: "got connection handle successfully")
                promise(.success(handle as NSNumber))
            }
        }
    }

    func releaseHandle(handle: NSNumber?) -> NSNumber {
        if handle == nil {
            return -1
        }

        logger.info(message: "releasing connection handle")
        return vcx.connectionRelease(handle!.intValue) as NSNumber
    }

    func connectionCreateWithInvite(
            inviteId: String,
            invitation: ConnectionInvitationDto
    ) -> Future<NSNumber, Error> {
        Future { promise in
            self.logger.info(message: "creating connection with invite")
            self.logger.debug(message: "connection invitation: \(invitation.toJson())")
            self.vcx.connectionCreate(
                    withInvite: inviteId,
                    inviteDetails: invitation.toJson(),
                    completion: { error, handle in
                        if self.isFail(error) {
                            self.logger.error(message: "error on creating connection with invite: \(error!.localizedDescription)")
                            promise(.failure(error!))
                            return
                        }
                        self.logger.info(message: "finished create connection with invite successfully")
                        self.logger.debug(message: "created connection handle: \(handle)")
                        promise(.success(handle as NSNumber))
                    })
        }
    }

    func connectionConnect(
            connectionHandle: NSNumber,
            connectionOptions: ConnectionOptionsDto
    ) -> Future<String, Error> {
        Future { promise in
            self.logger.info(message: "starting aries connection connect \(connectionHandle)")
            self.vcx.connectionConnect(
                    VcxHandle(truncating: connectionHandle),
                    connectionType: connectionOptions.toJson()) { error, result in
                if self.isFail(error) {
                    self.logger.error(message: "error on connection connect: \(error!.localizedDescription)")
                    promise(.failure(error!))
                    return
                }
                self.logger.info(message: "finished connection connect successfully")
                promise(.success(result!))
            }
        }
    }

}
