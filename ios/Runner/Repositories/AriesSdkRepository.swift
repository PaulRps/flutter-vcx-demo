//
//  AriesSdkRepository.swift
//  Runner
//
//  Created by Paulo Silva on 16/08/22.
//

import Foundation
import Combine

class AriesSdkRepository {
    private final let logger = CustomLogger(context: AriesSdkRepository.self)
    private final let ariesSdk: SdkPort
    private final var cancellables: Set<AnyCancellable>

    init(
            ariesSdk: SdkPort = AriesSdkAdapter()
    ) {
        self.ariesSdk = ariesSdk
        cancellables = Set()
    }

    func shutdownAriesSdk(isToDeleteWallet: Bool?) -> Bool {
        ariesSdk.shutdown(isToDeleteWallet: isToDeleteWallet)
    }

    func setSdkLogLevel(logLevel: AriesSdkLogLevelEnum?) {
        ariesSdk.setSdkLogLevel(logLevel: logLevel)
    }

    func clearSdkStorage() {
        let sdkStorage = ProcessInfo.processInfo.environment["HOME"]! + "/Documents/.indy_client/"
        let fileManager = FileManager.default
        do {
            logger.info(message: "cleaning sdk storage folder")
            //it will clear all sdk data (pool, wallet etc.)
            try fileManager.removeItem(atPath: sdkStorage)
            logger.info(message: "cleaned sdk storage folder")
        } catch {
            logger.info(message: "Could not clear sdk storage: \(error.localizedDescription)")
        }
    }

}
