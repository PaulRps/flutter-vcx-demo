//
// Created by Paulo Silva on 03/11/22.
//

import Foundation

class CreateConnectionInvitationResponseDto: NativeToFlutterResponseDto {

    let invitation: String
    let connectionHandle: String

    init(invitation: String, connectionHandle: String, errorMessage: ErrorMessageDto? = nil) {
        self.invitation = invitation
        self.connectionHandle = connectionHandle
        super.init(success: !invitation.isEmpty, errorMessage: errorMessage)
    }

    override func toMap() -> [String: Any] {
        var map = super.toMap()

        if !invitation.isEmpty {
            map["invitation"] = invitation
        }

        if !connectionHandle.isEmpty {
            map["connectionHandle"] = connectionHandle
        }

        return map
    }
}
