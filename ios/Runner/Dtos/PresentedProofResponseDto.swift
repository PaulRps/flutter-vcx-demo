//
// Created by Paulo Pereira on 18/11/22.
//

import Foundation

class PresentedProofResponseDto: NativeToFlutterResponseDto {
    let revealedAttributes: [String: Any]
    let selfAttestAttributes: [String: Any]

    init(
            success: Bool,
            errorMessage: ErrorMessageDto? = nil,
            revealedAttributes: [String: Any],
            selfAttestAttributes: [String: Any]
    ) {
        self.revealedAttributes = revealedAttributes
        self.selfAttestAttributes = selfAttestAttributes
        super.init(success: success, errorMessage: errorMessage)
    }

    override func toMap() -> [String: Any] {
        var map = super.toMap()

        if !revealedAttributes.isEmpty {
            map["revealedAttributes"] = revealedAttributes
        }

        if !selfAttestAttributes.isEmpty {
            map["selfAttestAttributes"] = selfAttestAttributes
        }

        return map
    }
}
