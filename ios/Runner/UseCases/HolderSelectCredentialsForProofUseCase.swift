//
// Created by Paulo Pereira on 20/11/22.
//

import Foundation
import SwiftyJSON

class HolderSelectCredentialsForProofUseCase {
    private final let logger = CustomLogger(context: HolderSelectCredentialsForProofUseCase.self)

    func select(matchingCredentials: String) -> String {
        logger.info(message: "selecting credential for proof")

        var jsonProofCredentials = try! JSON(data: matchingCredentials.data(using: .utf8)!)

        for (attrName, attrCredInfo): (String, JSON) in jsonProofCredentials["attrs"] {
            if attrCredInfo.array?.isEmpty == true {
                logger.error(message: "error on selecting credential attribute \(attrName) for proof")
                continue
            }

            let selectedCredential = jsonProofCredentials["attrs"][attrName][0]
            jsonProofCredentials["attrs"][attrName] = ["credential": selectedCredential]
        }

        return jsonProofCredentials.rawString()!
    }
}
