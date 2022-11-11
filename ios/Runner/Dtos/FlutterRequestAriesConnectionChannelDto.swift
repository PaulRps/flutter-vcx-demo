//
//  FlutterRequestAriesConnectionChannelDto.swift
//  Runner
//
//  Created by Paulo Silva on 26/08/22.
//

import Foundation

class FlutterRequestAriesConnectionChannelDto {
    let inviteId: String?
    let invitation: ConnectionInvitationDto?
    let connectionHandle: NSNumber?

    init(
            inviteId: String?,
            invitation: ConnectionInvitationDto?,
            connectionHandle: NSNumber?
    ) {
        self.inviteId = inviteId
        self.invitation = invitation
        self.connectionHandle = connectionHandle
    }

    static func from(call: FlutterMethodCall) -> FlutterRequestAriesConnectionChannelDto {
        let data = call.arguments as? [String: Any]
        return FlutterRequestAriesConnectionChannelDto(
                inviteId: data?["inviteId"] as? String,
                invitation: ConnectionInvitationDto.from(map: data?["invitation"] as? [String: Any]),
                connectionHandle: data?["connectionHandle"] as? NSNumber
        )
    }

}
