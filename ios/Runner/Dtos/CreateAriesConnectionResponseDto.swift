//
//  CreateAriesConnectionResponseDto.swift
//  Runner
//
//  Created by Paulo Silva on 02/09/22.
//

import Foundation

class CreateAriesConnectionResponseDto: NativeToFlutterResponseDto {
    let pairwiseDid: String?
    let connectionName: String?
    
    init(
        pairwiseDid: String?,
        connectionName: String?,
        success: Bool,
        errorMessage: ErrorMessageDto? = nil
    ) {
        self.pairwiseDid = pairwiseDid
        self.connectionName = connectionName
        super.init(success: success, errorMessage: errorMessage)
    }
    
    override func toMap() -> [String : Any] {
        var map = super.toMap()
        
        if pairwiseDid != nil && pairwiseDid?.isEmpty == false {
            map["pairwiseDid"] = pairwiseDid
        }
        
        if connectionName != nil && connectionName?.isEmpty == false {
            map["connectionName"] = connectionName
        }
        
        return map
    }
}
