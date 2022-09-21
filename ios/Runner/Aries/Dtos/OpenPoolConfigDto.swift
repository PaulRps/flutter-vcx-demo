//
//  OpenPoolConfigDto.swift
//  Runner
//
//  Created by Paulo Silva on 15/08/22.
//

import Foundation

class OpenPoolConfigDto: ToJson {
    final let genesisPath: String?

    final let poolName: String?

    final let poolConfig: String?

    init(
            genesisPath: String?,
            poolName: String?,
            poolConfig: String? = nil
    ) {
        self.genesisPath = genesisPath
        self.poolName = poolName
        self.poolConfig = poolConfig
    }

    enum CodingKeys: String, CodingKey {
        case genesisPath = "genesis_path"
        case poolName = "pool_name"
        case poolConfig = "pool_config"
    }

    static func from(openMainPoolConfig: [String: AnyObject]?) -> OpenPoolConfigDto {
        OpenPoolConfigDto(
                genesisPath: openMainPoolConfig?["genesisPath"] as? String,
                poolName: openMainPoolConfig?["poolName"] as? String,
                poolConfig: openMainPoolConfig?["poolConfig"] as? String
        )
    }
}
