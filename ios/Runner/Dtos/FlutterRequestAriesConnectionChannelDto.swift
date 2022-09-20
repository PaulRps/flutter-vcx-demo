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
    
    init(
        inviteId: String?,
        invitation: ConnectionInvitationDto?
    ){
        self.inviteId = inviteId
        self.invitation = invitation
    }
    
    static func from(call: FlutterMethodCall) -> FlutterRequestAriesConnectionChannelDto {
        let data = call.arguments as? [String: Any]
        return FlutterRequestAriesConnectionChannelDto(
            inviteId: data?["inviteId"] as? String,
            invitation: ConnectionInvitationDto.from(map: data?["invitation"] as? [String:Any])
        )
    }
    
}
