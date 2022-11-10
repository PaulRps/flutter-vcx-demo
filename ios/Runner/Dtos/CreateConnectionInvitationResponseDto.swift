//
// Created by Paulo Silva on 03/11/22.
//

import Foundation

class CreateConnectionInvitationResponseDto: NativeToFlutterResponseDto {

    let invitation: String

    init(invitation: String, errorMessage: ErrorMessageDto? = nil) {
        self.invitation = invitation
        super.init(success: !invitation.isEmpty, errorMessage: errorMessage)
    }

    override func toMap() -> [String: Any] {
        var map = super.toMap()

        if invitation.isEmpty == false {
            map["invitation"] = invitation
        }

        return map
    }
}
