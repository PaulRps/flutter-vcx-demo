//
// Created by Paulo Silva on 09/09/22.
//

import Foundation

class FlutterRequestAriesProofChannelDto {
    let pairwiseDid: String?
    let sourceId: String?

    init(
            pairwiseDid: String?,
            sourceId: String?
    ) {
        self.pairwiseDid = pairwiseDid
        self.sourceId = sourceId
    }

    static func from(_ call: FlutterMethodCall) -> FlutterRequestAriesProofChannelDto {
        let data = call.arguments as? [String: Any]
        return FlutterRequestAriesProofChannelDto(
                pairwiseDid: data?["pairwiseDid"] as? String,
                sourceId: data?["sourceId"] as? String
        )
    }
}
