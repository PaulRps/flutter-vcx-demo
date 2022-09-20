//
//  AriesLogLevel.swift
//  Runner
//
//  Created by Paulo Silva on 22/08/22.
//

import Foundation

enum AriesSdkLogLevelEnum: String {
    case DEBUG
    case INFO
    case TRACE
}

extension AriesSdkLogLevelEnum {
    static func from(level: String?) -> AriesSdkLogLevelEnum {
        switch(level?.uppercased()) {
        case "DEBUG": return .DEBUG
        case "INFO": return .INFO
        case "TRACE": return .TRACE
        default: return .INFO
        }
    }
}
