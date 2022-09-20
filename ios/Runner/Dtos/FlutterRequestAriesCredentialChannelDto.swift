//
// Created by Paulo Silva on 05/09/22.
//

import Foundation

class FlutterRequestAriesCredentialChannelDto {
    let pairwiseDid: String?
    let sourceId: String?

    init(
            pairwiseDid: String?,
            sourceId: String?
    ) {
        self.pairwiseDid = pairwiseDid
        self.sourceId = sourceId
    }

    static func from(_ call: FlutterMethodCall) -> FlutterRequestAriesCredentialChannelDto {
        let data = call.arguments as? [String: String]
        return FlutterRequestAriesCredentialChannelDto(
                pairwiseDid: data?["pairwiseDid"],
                sourceId: data?["sourceId"]
        )
    }
}