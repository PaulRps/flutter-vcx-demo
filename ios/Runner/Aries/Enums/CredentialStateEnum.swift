//
// Created by Paulo Silva on 05/09/22.
//

import Foundation

enum CredentialStateEnum {
    case UNKNOWN
    case INITIAL
    case PROPOSAL_SENT
    case OFFER_RECEIVED
    case REQUEST_SENT
    case FINISHED

    var value: String {
        switch self {
        case .INITIAL: return "initial"
        case .PROPOSAL_SENT: return "proposal_sent"
        case .OFFER_RECEIVED: return "offer_received"
        case .REQUEST_SENT: return "request_sent"
        case .FINISHED: return "finished"
        case .UNKNOWN: return "unknown"
        }
    }

    static func getOne(value: String) -> CredentialStateEnum {
        switch value {
        case "initial": return .INITIAL
        case "proposal_sent": return .PROPOSAL_SENT
        case "offer_received": return .OFFER_RECEIVED
        case "request_sent": return .REQUEST_SENT
        case "finished": return .FINISHED
        default: return .UNKNOWN
        }
    }

    static func getOne(id: Int) -> CredentialStateEnum {
        var value: CredentialStateEnum {
            switch id {
            case 0: return .INITIAL
            case 1: return .PROPOSAL_SENT
            case 2: return .OFFER_RECEIVED
            case 3: return .REQUEST_SENT
            case 4: return .FINISHED
            default: return .UNKNOWN
            }
        }
        return value
    }
}