//
//  GetAgencyMessageResponseDto.swift
//  Runner
//
//  Created by Paulo Silva on 01/09/22.
//

import Foundation

class GetAriesAgencyMessageDto: NativeToFlutterResponseDto {
    let msg: String
    let pairwiseDid: String

    init(
            msg: String,
            pairwiseDid: String,
            success: Bool,
            errorMessage: ErrorMessageDto? = nil
    ) {
        self.msg = msg
        self.pairwiseDid = pairwiseDid
        super.init(success: success, errorMessage: errorMessage)
    }

    override func toMap() -> [String: Any] {
        var map = super.toMap()

        if !msg.isEmpty {
            map["msg"] = msg
        }

        if !pairwiseDid.isEmpty {
            map["pairwiseDid"] = pairwiseDid
        }

        return map
    }
}
