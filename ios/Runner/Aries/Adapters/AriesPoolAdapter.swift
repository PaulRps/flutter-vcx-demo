//
//  AriesMainPoolAdapter.swift
//  Runner
//
//  Created by Paulo Silva on 18/08/22.
//

import Foundation
import Combine
import vcx

class AriesPoolAdapter: PoolPort {
    private final let logger = CustomLogger(context: AriesPoolAdapter.self)
    private final let vcx: VcxAPI

    init() {
        vcx = VcxAPI()
    }

    func initPool(config: InitThreadPoolConfigDto) -> Future<Bool, Error> {
        Future { promise in
            self.logger.info(message: "initializing thread pool with config: \(config.toJson())")

            let response = self.vcx.vcxInitThreadPool(config.toJson())
            let isSuccess = self.isSuccessCode(Int(response))

            self.logger.info(message: "finished initialization of thread pool success(\(isSuccess))")

            if isSuccess {
                promise(.success(true))
            } else {
                self.logger.error(message: "error on initializing thread pool")
                promise(.failure(CustomError(errorMessage: .ARIES_SDK_INIT_ERROR)))
            }
        }
    }

    func openMainPool(config: OpenPoolConfigDto) -> Future<String, Error> {
        Future { promise in
            self.logger.info(message: "openning main pool")
            self.logger.debug(message: "main pool config: \(config.toJson())")
            self.vcx.vcxOpenMainPool(config.toJson(), completion: { error in
                if self.isFail(error) {
                    self.logger.error(message: "error on opening main pool: \(error!.localizedDescription)")
                    promise(.failure(error!))
                    return
                }

                self.logger.info(message: "opened main pool successfully")
                promise(.success(config.toJson()))
            })
        }
    }

}
