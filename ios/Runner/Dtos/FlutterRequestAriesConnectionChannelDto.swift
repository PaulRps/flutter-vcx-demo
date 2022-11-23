//
//  FlutterRequestAriesConnectionChannelDto.swift
//  Runner
//
//  Created by Paulo Silva on 26/08/22.
//

import Foundation
import Flutter

class FlutterRequestAriesConnectionChannelDto {
    let sourceId: String?
    let invitation: ConnectionInvitationDto?
    let connectionHandle: NSNumber?
    let isToDeleteHandle: Bool?

    init(
            sourceId: String?,
            invitation: ConnectionInvitationDto?,
            connectionHandle: NSNumber?,
            isToDeleteHandle: Bool?
    ) {
        self.sourceId = sourceId
        self.invitation = invitation
        self.connectionHandle = connectionHandle
        self.isToDeleteHandle = isToDeleteHandle
    }

    static func from(call: FlutterMethodCall) -> FlutterRequestAriesConnectionChannelDto {
        let data = call.arguments as? [String: Any]
        let handle:String = (data?["connectionHandle"] as? String) ?? "-1"
        return FlutterRequestAriesConnectionChannelDto(
                sourceId: data?["sourceId"] as? String,
                invitation: ConnectionInvitationDto.from(map: data?["invitation"] as? [String: Any]),
                connectionHandle: NSNumber(value: Int64(handle) ?? -1),
                isToDeleteHandle: data?["isToDeleteHandle"] as? Bool
        )
    }

}
