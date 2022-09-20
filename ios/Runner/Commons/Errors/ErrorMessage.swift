//
//  ErrorMessage.swift
//  Runner
//
//  Created by Paulo Silva on 13/08/22.
//

import Foundation

enum ErrorMessage {
    case INTERNAL_ERROR
    case ARIES_SDK_INIT_ERROR
    case ARIES_SDK_SHUTDOWN_ERROR
    case ARIES_SDK_RESET_ERROR
}

extension ErrorMessage {
    var data: ErrorMessageDto {
        get {
            switch self {
            case .INTERNAL_ERROR: return ErrorMessageDto(id: "0", message: "internal error")
            case .ARIES_SDK_INIT_ERROR: return  ErrorMessageDto(id: "1", message: "Aries SDK init error")
            case .ARIES_SDK_SHUTDOWN_ERROR: return ErrorMessageDto(id: "2", message: "Aries SDK shutdown error")
            case .ARIES_SDK_RESET_ERROR: return ErrorMessageDto(id: "3", message: "Aries SDK reset error")
            }
        }
    }
}
