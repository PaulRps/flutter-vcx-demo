//
//  AriesStartSdkResponseDto.swift
//  Runner
//
//  Created by Paulo Silva on 19/08/22.
//

import Foundation

class StartAriesSdkResponseDto: NativeToFlutterResponseDto {
    
    final let agentDid: String?
    
    init(
        success: Bool,
        errorMessage: ErrorMessageDto?=nil,
        agentDid: String?=nil
    ) {
        self.agentDid = agentDid
        super.init(success: success, errorMessage: errorMessage)
    }
    
    
    override func toMap() -> [String:Any] {
        var response = super.toMap()

        if agentDid?.isEmpty == false {
            response["agentDid"] = agentDid! as Any
        }

        return response
    }
}
