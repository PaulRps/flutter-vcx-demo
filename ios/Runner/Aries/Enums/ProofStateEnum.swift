//
// Created by Paulo Silva on 09/09/22.
//

import Foundation

enum ProofProverStateEnum {
    case UNKNOWN
    case INITIAL
    case PRESENTATION_PROPOSAL_SENT
    case PRESENTATION_REQUEST_RECEIVED
    case PRESENTATION_PREPARED
    case PRESENTATION_PREPARATION_FAILED
    case PRESENTATION_SENT
    case FINISHED

    var value: String {
        switch self {
        case .INITIAL: return "initial"
        case .PRESENTATION_PROPOSAL_SENT: return "presentation_proposal_sent"
        case .PRESENTATION_REQUEST_RECEIVED: return "presentation_request_received"
        case .PRESENTATION_PREPARED: return "presentation_prepared"
        case .PRESENTATION_PREPARATION_FAILED: return "presentation_preparation_failed"
        case .PRESENTATION_SENT: return "presentation_sent"
        case .FINISHED: return "finished"
        case .UNKNOWN: return "unknown"
        }
    }

    static func getOne(value: String) -> ProofProverStateEnum {
        switch value {
        case "initial": return .INITIAL
        case "presentation_proposal_sent": return .PRESENTATION_PROPOSAL_SENT
        case "presentation_request_received": return .PRESENTATION_REQUEST_RECEIVED
        case "presentation_prepared": return .PRESENTATION_PREPARED
        case "presentation_preparation_failed": return .PRESENTATION_PREPARATION_FAILED
        case "presentation_sent": return .PRESENTATION_SENT
        case "finished": return .FINISHED
        default: return .UNKNOWN
        }
    }

    static func getOne(id: Int) -> ProofProverStateEnum {
        var value: ProofProverStateEnum {
            switch id {
            case 0: return .INITIAL
            case 1: return .PRESENTATION_PROPOSAL_SENT
            case 2: return .PRESENTATION_REQUEST_RECEIVED
            case 3: return .PRESENTATION_PREPARED
            case 4: return .PRESENTATION_PREPARATION_FAILED
            case 5: return .PRESENTATION_SENT
            case 6: return .FINISHED
            default: return .UNKNOWN
            }
        }
        return value
    }
}

enum ProofVerifierStateEnum {
    case UNKNOWN
    case INITIALIZED
    case PRESENTATION_REQUEST_SET
    case PRESENTATION_PROPOSAL_RECEIVED
    case PRESENTATION_REQUEST_SENT
    case FINISHED
    case FAILED

    var value: String {
        switch self {
        case .INITIALIZED: return "initialized"
        case .PRESENTATION_REQUEST_SET: return "presentation_request_set"
        case .PRESENTATION_PROPOSAL_RECEIVED: return "presentation_proposal_received"
        case .PRESENTATION_REQUEST_SENT: return "presentation_request_sent"
        case .FINISHED: return "finished"
        case .FAILED: return "failed"
        default: return "unknown"
        }
    }

    static func getOne(id: Int) -> ProofVerifierStateEnum {
        var value: ProofVerifierStateEnum {
            switch id {
            case 0: return .INITIALIZED
            case 1: return .PRESENTATION_REQUEST_SET
            case 2: return .PRESENTATION_PROPOSAL_RECEIVED
            case 3: return .PRESENTATION_REQUEST_SENT
            case 4: return .FINISHED
            case 5: return .FAILED
            default: return .UNKNOWN
            }
        }
        return value
    }
}
