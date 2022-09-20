//
//  FlutterRequestAriesMessageChannelDto.swift
//  Runner
//
//  Created by Paulo Silva on 31/08/22.
//

import Foundation
import Flutter

class FlutterRequestAriesMessageChannelDto {
    let msgUuid: String?
    let msgStatus: AgencyMessageStatusEnum
    let pairwiseDid: String?
    
    init(
        msgUuid: String?,
        msgStatus: AgencyMessageStatusEnum,
        pairwiseDid: String?
    ){
        self.msgUuid = msgUuid
        self.msgStatus = msgStatus
        self.pairwiseDid = pairwiseDid
    }
    
    static func from(_ call: FlutterMethodCall) -> FlutterRequestAriesMessageChannelDto {
        let data = call.arguments as? [String:String]
        return FlutterRequestAriesMessageChannelDto(
            msgUuid: data?["msgUuid"],
            msgStatus: AgencyMessageStatusEnum.getOne(data?["msgStatus"]),
            pairwiseDid: data?["pairwiseDid"]
        )
    }
}
