//
//  AriesAgencyAdapter.swift
//  Runner
//
//  Created by Paulo Silva on 18/08/22.
//

import Foundation
import Combine
import vcx

class AriesAgencyAdapter: AgencyPort, CheckVcxResult {

    private final let logger = CustomLogger(context: AriesAgencyAdapter.self)
    private final let vcx: ConnectMeVcx

    init() {
        vcx = ConnectMeVcx()
    }

    func provisionCloudAgency(config: ProvisionAgencyConfigDto) -> Future<String, Error> {
        Future { promise in
            self.logger.info(
                    message: "provisioning cloud agent (mediator) with config: \(config.toJson())"
            )
            self.vcx.vcxProvisionCloudAgent(config.toJson(), completion: { error, provision in
                if self.isFail(error) || provision?.isEmpty == true {
                    self.logger.error(message: "error on provisioning cloud agency: \(error?.localizedDescription ?? "")")
                    promise(.failure(error ?? CustomError(errorMessage: .INTERNAL_ERROR)))
                    return
                }

                self.logger.info(message: "provisioned cloud agency successfully")
                self.logger.debug(message: "provisioned cloud agency config: \(provision!)")
                promise(.success(provision!))
            })
        }
    }

    func createAgency(forMainWallet: String) -> Future<String, Error> {
        Future { promise in
            self.logger.info(
                    message: "creating agency client with config: \(forMainWallet)"
            )
            self.vcx.vcxCreateAgencyClient(forMainWallet: forMainWallet, completion: { error in
                if self.isFail(error) {
                    self.logger.error(message: "error on creating agency for main wallet: \(error!.localizedDescription)")
                    promise(.failure(error!))
                    return
                }

                self.logger.info(message: "provisioned cloud agency successfully")
                promise(.success(forMainWallet))
            })
        }
    }

    func getMessage(
            connectionHandle: NSNumber?,
            messageStatus: AgencyMessageStatusEnum,
            messageUid: String? = ""
    ) -> Future<String, Error> {
        Future { promise in
            if connectionHandle == nil {
                promise(.failure(CustomError(errorMessage: .INTERNAL_ERROR)))
                return
            }

            self.logger.info(message: "getting aries message from agency")
            self.vcx.downloadMessagesV2(
                    String(connectionHandle!.intValue),
                    messageStatus: messageStatus.value,
                    uid_s: messageUid) { error, messageJson in
                if self.isFail(error) || messageJson?.isEmpty == true {
                    self.logger.error(message: "error on getting agency message: \(error!.localizedDescription)")
                    promise(.failure(error!))
                    return
                }

                self.logger.info(message: "got agency message successfully")
                self.logger.debug(message: "agency message: \(messageJson!)")
                promise(.success(messageJson!))
            }
        }
    }

    func updateMessageStatus(
            newStaus: AgencyMessageStatusEnum,
            msg: UpdateAgencyMessageStatus
    ) -> Future<Bool, Error> {
        Future { promise in
            self.vcx.updateMessages(
                    newStaus.value,
                    pwdidsJson: msg.toJson()) { error in
                if self.isFail(error) {
                    self.logger.error(message: "error on updating agency message status: \(error!.localizedDescription)")
                    promise(.failure(error!))
                    return
                }

                self.logger.info(message: "updated agency message status successfully")
                promise(.success(true))
            }
        }
    }

}
