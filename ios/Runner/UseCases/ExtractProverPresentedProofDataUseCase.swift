//
// Created by Paulo Pereira on 19/11/22.
//

import Foundation
import SwiftyJSON

class ExtractProverPresentedProofDataUseCase {
    func extract(presentedProofJson: String) -> (revealedAttrs: [String: Any], selfAttestedAttrs: [String: Any]) {
        let msgJson = (try? JSON(data: presentedProofJson.data(using: .utf8) ?? Data())) ?? JSON("")

        var revealedAttrsValueMap: [String: String] = [:]
        for (_, proof): (String, JSON) in msgJson["proof"]["proofs"] {
            for (attrName, attrEncodedValue): (String, JSON) in proof["primary_proof"]["eq_proof"]["revealed_attrs"] {
                revealedAttrsValueMap[attrEncodedValue.stringValue] = attrName
            }
        }

        var revealedAttrs: [String: Any] = [:]
        for (_, attrValue): (String, JSON) in msgJson["requested_proof"]["revealed_attrs"] {
            let attrName = revealedAttrsValueMap[attrValue["encoded"].stringValue]
            revealedAttrs[attrName!] = attrValue["raw"].stringValue
        }

        var selfAttestedAttrs: [String: Any] = [:]
        let selfAttrs = msgJson["requested_proof"]["self_attested_attrs"]
        for (attrName, attrValue): (String, JSON) in selfAttrs {
            selfAttestedAttrs[attrName] = attrValue.stringValue
        }

        return (revealedAttrs: revealedAttrs, selfAttestedAttrs: selfAttestedAttrs)
    }
}
