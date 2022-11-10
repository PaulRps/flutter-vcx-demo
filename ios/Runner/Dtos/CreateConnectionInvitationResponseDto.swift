//
// Created by Paulo Silva on 03/11/22.
//

import Foundation

class CreateConnectionInvitationResponseDto: NativeToFlutterResponseDto {

    let invitation: String
    let connectionHandle: NSNumber

    init(invitation: String, connectionHandle: NSNumber, errorMessage: ErrorMessageDto? = nil) {
        self.invitation = invitation
        self.connectionHandle = connectionHandle
        super.init(success: !invitation.isEmpty, errorMessage: errorMessage)
    }

    override func toMap() -> [String: Any] {
        var map = super.toMap()

        if invitation.isEmpty == false {
            map["invitation"] = invitation
        }

        if connectionHandle.intValue > 0 {
            map["connectionHandle"] = connectionHandle.intValue
        }

        return map
    }
}
