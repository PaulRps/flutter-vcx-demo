//
//  WalletManagerAdapter.swift
//  Runner
//
//  Created by Paulo Silva on 16/08/22.
//

import Foundation
import Combine
import vcx

class LocalWalletManagerAdapter: WalletManagerPort {
    
    private final let logger = CustomLogger(context: LocalWalletManagerAdapter.self)
    private final let vcx: ConnectMeVcx
    
    init() {
        vcx = ConnectMeVcx()
    }
    
    func createWallet(config: LocalWalletConfigDto) -> Future<Int, Error> {
        Future { promise in
            self.logger.info(message: "creating and opening wallet with config: \(config.toJson())")
            self.vcx.createWallet(config.toJson(), completion: { error in
                if self.isFail(error) {
                    self.logger.error(message: "error on creating and opening wallet: \(error!.localizedDescription)")
                    promise(.failure(error!))
                    return
                }

                self.logger.info(message: "created wallet successfully")

                promise(.success(0))
            })
        }
    }
    
    func openWallet(config: LocalWalletConfigDto) -> Future<Int, Error> {
        Future { promise in
            self.logger.info(message: "opening wallet")
            self.logger.debug(message: "wallet config: \(config.toJson())")

            self.vcx.openMainWallet(config.toJson(), completion: { error, handle in
                if self.isFail(error) {
                    self.logger.error(message: "error on opening wallet: \(error!.localizedDescription)")
                    promise(.failure(error!))
                    return
                }

                self.logger.info(message: "opened wallet successfully")
                self.logger.debug(message: "wallet handle: \(handle)")
                promise(.success(handle))
            })
        }
    }
    
    func closeWallet() -> Future<Bool, Error> {
        Future { promise in
            self.logger.info(message: "closing wallet")

            self.vcx.closeMainWallet({ error in
                if self.isFail(error) {
                    self.logger.error(message: "error on closing wallet: \(error!.localizedDescription)")
                    promise(.failure(error!))
                    return
                }

                self.logger.info(message: "closed wallet successfully")

                promise(.success(true))
            })
        }
    }
    
}
