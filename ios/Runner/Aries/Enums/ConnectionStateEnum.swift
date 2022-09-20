//
//  ConnectionStateEnum.swift
//  Runner
//
//  Created by Paulo Silva on 26/08/22.
//

import Foundation

enum ConnectionStateEnum {
    case INITIALIZED
    case REQUEST_SENT
    case OFFER_RECEIVED
    case ACCEPTED
    case UNKNOWN
    
    
    var value : String {
        switch self
        {
        case .INITIALIZED: return "initialized"
        case .REQUEST_SENT: return "request_sent"
        case .OFFER_RECEIVED: return "offer_received"
        case .ACCEPTED: return "accepted"
        case .UNKNOWN: return "unknown"
        }
    }
    
    static func getOne(value: String) -> ConnectionStateEnum {
        switch value {
        case "initialized": return .INITIALIZED
        case "request_sent": return .REQUEST_SENT
        case "offer_received": return .OFFER_RECEIVED
        case "accepted": return .ACCEPTED
        default: return .UNKNOWN
        }
    }
    
    static func getOne(id: Int) -> ConnectionStateEnum {
        var value : ConnectionStateEnum {
            switch id
            {
            case 1: return .INITIALIZED
            case 2: return .REQUEST_SENT
            case 3: return .OFFER_RECEIVED
            case 4: return .ACCEPTED
            default: return .UNKNOWN
            }
        }
        return value
    }
}
