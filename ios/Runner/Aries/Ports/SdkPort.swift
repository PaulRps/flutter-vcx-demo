//
//  AriesSdkPort.swift
//  Runner
//
//  Created by Paulo Silva on 16/08/22.
//

import Foundation
import Combine

protocol SdkPort {
    func setSdkLogLevel(logLevel: AriesSdkLogLevelEnum?)
    
    func shutdown(isToDeleteWallet: Bool?) -> Bool
}
