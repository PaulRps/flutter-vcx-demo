//
// Created by Paulo Silva on 09/09/22.
//

import Foundation

class FlutterRequestAriesProofChannelDto {
    let pairwiseDid: String?
    let sourceId: String?
    let proofName: String?
    let requestedAttributes: [RequestedProofAttribute]?

    init(
            pairwiseDid: String?,
            sourceId: String?,
            proofName: String?,
            requestedAttributes: [RequestedProofAttribute]?
    ) {
        self.pairwiseDid = pairwiseDid
        self.sourceId = sourceId
        self.proofName = proofName
        self.requestedAttributes = requestedAttributes
    }

    static func from(_ call: FlutterMethodCall) -> FlutterRequestAriesProofChannelDto {
        let data = call.arguments as? [String: Any]
        let reqAttrs = (data?["requestedAttributes"] as? [[String: String]])

        return FlutterRequestAriesProofChannelDto(
                pairwiseDid: data?["pairwiseDid"] as? String,
                sourceId: data?["sourceId"] as? String,
                proofName: data?["proofName"] as? String,
                requestedAttributes: reqAttrs?.map { element -> RequestedProofAttribute in
                    RequestedProofAttribute.from(map: element)
                }
        )
    }
}

class RequestedProofAttribute {
    let name: String
    let schemaName: String
    let schemaVersion: String

    init(
            name: String,
            schemaName: String,
            schemaVersion: String
    ) {
        self.name = name
        self.schemaName = schemaName
        self.schemaVersion = schemaVersion
    }

    static func from(map: [String: String]) -> RequestedProofAttribute {
        RequestedProofAttribute(
                name: map["name"]!,
                schemaName: map["schemaName"]!,
                schemaVersion: map["schemaVersion"]!
        )
    }
}