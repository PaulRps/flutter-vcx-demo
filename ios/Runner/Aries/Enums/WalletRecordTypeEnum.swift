//
//  WalletRecordTypeEnum.swift
//  Runner
//
//  Created by Paulo Silva on 26/08/22.
//

import Foundation


enum WalletRecordTypeEnum: Codable {
    case CONNECTION
    case CREDENTIAL
    case UNKNOWN(value: String)
    
    var value : String {
        switch self
        {
        case .CONNECTION: return "connection"
        case .CREDENTIAL: return "credential"
        case .UNKNOWN(value: let value): return value
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let status = try? container.decode(String.self)
        switch status {
        case "connection": self = .CONNECTION
        case "credential": self = .CREDENTIAL
        default:
            self = .UNKNOWN(value: status ?? "unknown")
        }
    }
    
    static func getOne(_ name: String) -> WalletRecordTypeEnum {
        switch name {
        case "connection": return .CONNECTION
        case "credential": return .CREDENTIAL
        default: return .UNKNOWN(value: "unknown")
        }
    }
}
