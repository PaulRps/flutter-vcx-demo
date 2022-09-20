//
//  ConnectionOptionsDto.swift
//  Runner
//
//  Created by Paulo Silva on 26/08/22.
//

import Foundation

class ConnectionOptionsDto: ToJson {
    var usePublicDid: Bool?

    enum CodingKeys: String, CodingKey {
        case usePublicDid = "use_public_did"
    }

    init(usePublicDid: Bool? = false) {
       self.usePublicDid = usePublicDid
    }
}
