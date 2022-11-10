//
//  AriesSdkAdapter.swift
//  Runner
//
//  Created by Paulo Silva on 16/08/22.
//

import Foundation
import Combine
import vcx

class AriesSdkAdapter: SdkPort, CheckVcxResult {
    private final let logger = CustomLogger(context: AriesSdkAdapter.self)
    private final let vcx: VcxAPI
    private final var cancellables: Set<AnyCancellable>

    init() {
        vcx = VcxAPI()
        cancellables = Set()
    }

    func setSdkLogLevel(logLevel: AriesSdkLogLevelEnum?) {
        logger.info(message: "setting aries sdk log level to \(logLevel?.rawValue)")

//        VcxLogger.setDefault(/*logLevel?.rawValue.lowercased()*/)
    }

    func shutdown(isToDeleteWallet: Bool?) -> Bool {
        logger.info(message: "shutting down aries sdk (isToDeleteWallet=\(isToDeleteWallet))")
        let shutdownResult = vcx.vcxShutdown(isToDeleteWallet ?? false)
        return isSuccessCode(Int(shutdownResult))
    }

}
