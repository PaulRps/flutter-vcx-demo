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
    private final var cancellables:Set<AnyCancellable>
    
    init(
        ariesSdk: SdkPort=AriesSdkAdapter()
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

}
