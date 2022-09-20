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
    private final let vcx: ConnectMeVcx
    private final var cancellables: Set<AnyCancellable>
    
    init() {
        self.vcx = ConnectMeVcx()
        self.cancellables = Set()
    }
    
    func setSdkLogLevel(logLevel: AriesSdkLogLevelEnum?) {
        VcxLogger.setDefault(logLevel?.rawValue)
    }
    
    func shutdown(isToDeleteWallet: Bool?) -> Bool {
        let pointer = UnsafeMutablePointer<ObjCBool>.allocate(capacity: 1)
        pointer[0] = ObjCBool(isToDeleteWallet ?? false)
        let shutdownResult = self.vcx.vcxShutdown(pointer)
        return self.isSuccessCode(Int(shutdownResult))
    }
    
}
