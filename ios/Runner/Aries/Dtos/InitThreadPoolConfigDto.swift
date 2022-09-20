//
//  InitThreadPoolConfigDto.swift
//  Runner
//
//  Created by Paulo Silva on 15/08/22.
//

import Foundation

class InitThreadPoolConfigDto: ToJson {
    
    final let numThreads: Int?
    
    init(numThreads: Int?=nil) {
        self.numThreads = numThreads
    }
    
    enum CodingKeys: String, CodingKey {
        case numThreads = "num_threads"
    }
    
    static func from(initThreadPoolConfig: [String:AnyObject]?) -> InitThreadPoolConfigDto {
        return InitThreadPoolConfigDto(
            numThreads: initThreadPoolConfig?["numThreads"] as? Int
        )
    }
}
