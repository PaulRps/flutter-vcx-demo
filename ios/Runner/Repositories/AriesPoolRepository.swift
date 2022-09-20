//
//  AriesPoolRepository.swift
//  Runner
//
//  Created by Paulo Silva on 30/08/22.
//

import Foundation
import Combine

class AriesPoolRepository {
    private final let ariesPool: PoolPort
    
    init(
        ariesPool: PoolPort=AriesMainPoolAdapter()
    ){
        self.ariesPool = ariesPool
    }
    
    func initPool(config: InitThreadPoolConfigDto) -> Future<Bool, Error>{
        return self.ariesPool.initPool(config: config)
    }
    
    func openMainPool(config: OpenPoolConfigDto) -> Future<String, Error>{
        return self.ariesPool.openMainPool(config: config)
    }
}
