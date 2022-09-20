//
//  AgencyMessageStatusEnum.swift
//  Runner
//
//  Created by Paulo Silva on 31/08/22.
//

import Foundation

enum AgencyMessageStatusEnum : CustomStringConvertible{
    case CREATED
    case SENT
    case RECEIVED
    case ACCEPTED
    case REJECTED
    case REVIEWED
    
    var value : String {
        switch self
        {
        case .CREATED: return "MS-101"
        case .SENT: return "MS-102"
        case .RECEIVED: return "MS-103"
        case .ACCEPTED: return "MS-104"
        case .REJECTED: return "MS-105"
        case .REVIEWED: return "MS-106"
        }
    }
    
    var description: String {
        switch self
        {
        case .CREATED: return "MS-101"
        case .SENT: return "MS-102"
        case .RECEIVED: return "MS-103"
        case .ACCEPTED: return "MS-104"
        case .REJECTED: return "MS-105"
        case .REVIEWED: return "MS-106"
        }
    }
    
    static func getOne(_ str : String?) -> AgencyMessageStatusEnum{
        switch str
        {
        case "MS-101": return .CREATED
        case "MS-102": return .SENT
        case "MS-103" : return .RECEIVED
        case "MS-104" : return .ACCEPTED
        case "MS-105" : return .REJECTED
        case "MS-106" : return .REVIEWED
        default       : return .CREATED
        }
        
    }
}
