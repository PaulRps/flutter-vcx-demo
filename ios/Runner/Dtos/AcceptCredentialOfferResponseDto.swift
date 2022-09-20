//
// Created by Paulo Silva on 16/09/22.
//

import Foundation

class AcceptCredentialOfferResponseDto: NativeToFlutterResponseDto {
    let credentialName: String

    init(
            credentialName: String,
            success: Bool,
            errorMessage: ErrorMessageDto? = nil
    ) {
        self.credentialName = credentialName
        super.init(success: success, errorMessage: errorMessage)
    }

    override func toMap() -> [String: Any] {
        var map = super.toMap()

        if !credentialName.isEmpty {
            map["credentialName"] = credentialName
        }

        return map
    }
}
