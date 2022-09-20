//
//  PoolPort.swift
//  Runner
//
//  Created by Paulo Silva on 18/08/22.
//

import Foundation
import Combine

protocol PoolPort: CheckVcxResult {
    func initPool(config: InitThreadPoolConfigDto) -> Future<Bool, Error>
    
    func openMainPool(config: OpenPoolConfigDto) -> Future<String, Error>
}
