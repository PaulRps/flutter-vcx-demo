//
// Created by Paulo Silva on 05/09/22.
//

import Foundation

enum CredentialHolderStateEnum {
    case UNKNOWN
    case INITIAL
    case PROPOSAL_SENT
    case OFFER_RECEIVED
    case REQUEST_SENT
    case FINISHED
    case FAILED

    var value: String {
        switch self {
        case .INITIAL: return "initial"
        case .PROPOSAL_SENT: return "proposal_sent"
        case .OFFER_RECEIVED: return "offer_received"
        case .REQUEST_SENT: return "request_sent"
        case .FINISHED: return "finished"
        case .FAILED: return "failed"
        case .UNKNOWN: return "unknown"
        }
    }

    static func getOne(value: String) -> CredentialHolderStateEnum {
        switch value {
        case "initial": return .INITIAL
        case "proposal_sent": return .PROPOSAL_SENT
        case "offer_received": return .OFFER_RECEIVED
        case "request_sent": return .REQUEST_SENT
        case "finished": return .FINISHED
        case "failed": return .FAILED
        default: return .UNKNOWN
        }
    }

    static func getOne(id: UInt) -> CredentialHolderStateEnum {
        var value: CredentialHolderStateEnum {
            switch id {
            case 0: return .INITIAL
            case 1: return .PROPOSAL_SENT
            case 2: return .OFFER_RECEIVED
            case 3: return .REQUEST_SENT
            case 4: return .FINISHED
            case 5: return .FAILED
            default: return .UNKNOWN
            }
        }
        return value
    }
}

enum CredentialIssuerStateEnum {
    case UNKNOWN
    case INITIAL
    case PROPOSAL_RECEIVED
    case OFFER_SET
    case OFFER_SENT
    case REQUEST_RECEIVED
    case CREDENTIAL_SENT
    case FINISHED
    case FAILED

    static func getOne(id: Int) -> CredentialIssuerStateEnum {
        var value: CredentialIssuerStateEnum {
            switch id {
            case 0: return .INITIAL
            case 1: return .PROPOSAL_RECEIVED
            case 2: return .OFFER_SET
            case 3: return .OFFER_SENT
            case 4: return .REQUEST_RECEIVED
            case 5: return .CREDENTIAL_SENT
            case 5: return .FINISHED
            case 5: return .FAILED
            default: return .UNKNOWN
            }
        }
        return value
    }
}