//
//  NativeToFlutterDto.swift
//  Runner
//
//  Created by Paulo Silva on 14/08/22.
//

import Foundation

class NativeToFlutterResponseDto {
    var success: Bool
    
    var errorMessage: ErrorMessageDto?
    
    init(
        success: Bool,
        errorMessage: ErrorMessageDto?=nil
    ){
        self.success = success
        self.errorMessage = errorMessage
    }
    
    func toMap() -> [String:Any] {
        var map =  [
            "success": success as Any
        ]
        
        if errorMessage != nil {
            map["error"] = errorMessage!.toMap()
        }
        
        return map
    }
}


extension NativeToFlutterResponseDto {
    static func error(error: ErrorMessage) -> NativeToFlutterResponseDto {
        return NativeToFlutterResponseDto(success: false, errorMessage: error.data)
    }
}
