//
//  ConnectionStateEnum.swift
//  Runner
//
//  Created by Paulo Silva on 26/08/22.
//

import Foundation

enum ConnectionStateEnum {
    case INITIALIZED
    case INVITED
    case REQUESTED
    case RESPONDED
    case FINISHED
    case UNKNOWN


    var value: String {
        switch self {
        case .INITIALIZED: return "initialized"
        case .INVITED: return "invited"
        case .REQUESTED: return "requested"
        case .RESPONDED: return "responded"
        case .FINISHED: return "finished"
        case .UNKNOWN: return "unknown"
        }
    }

    static func getOne(value: String) -> ConnectionStateEnum {
        switch value {
        case "initialized": return .INITIALIZED
        case "invited": return .INVITED
        case "requested": return .REQUESTED
        case "responded": return .RESPONDED
        case "finished": return .FINISHED
        default: return .UNKNOWN
        }
    }

    static func getOne(id: Int) -> ConnectionStateEnum {
        var value: ConnectionStateEnum {
            switch id {
            case 0: return .INITIALIZED
            case 1: return .INVITED
            case 2: return .REQUESTED
            case 3: return .RESPONDED
            case 4: return .FINISHED
            default: return .UNKNOWN
            }
        }
        return value
    }
}
