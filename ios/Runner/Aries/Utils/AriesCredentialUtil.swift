//
// Created by Paulo Silva on 16/09/22.
//

import Foundation

class AriesCredentialUtil {

    static func getCredentialNameVersion(from: String) -> [String: String] {
        var result = [String: String]()
        let map = JsonUtil.toDictionary(from)
        let data = map?["data"] as? [String: AnyObject]
        let holder = data?["holder_sm"] as? [String: AnyObject]
        let state = holder?["state"] as? [String: AnyObject]
        let finished = state?["Finished"] as? [String: AnyObject]
        let credential = finished?["credential"] as? [String: AnyObject]
        let attachs = credential?["credentials~attach"] as? Array<AnyObject>
        let firstAttach = attachs?[0] as? [String: AnyObject]
        let dataAttached = firstAttach?["data"] as? [String: AnyObject]
        let base64 = dataAttached?["base64"] as? String
        let decodedData = Data(base64Encoded: base64!)!
        let decodedString = String(data: decodedData, encoding: .utf8)!
        let decodedCredential = JsonUtil.toDictionary(decodedString)
        let schemaId = decodedCredential?["schema_id"] as? String

        let schemaDefinition = schemaId?.components(separatedBy: ":")

        result["name"] = schemaDefinition?[2] as? String
        result["version"] = schemaDefinition?[3] as? String

        return result
    }
}
