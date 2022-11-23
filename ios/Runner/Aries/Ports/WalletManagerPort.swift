//
//  WalletManagerPort.swift
//  Runner
//
//  Created by Paulo Silva on 16/08/22.
//

import Foundation
import Combine

protocol WalletManagerPort: CheckVcxResult {
    
    func createWallet(config: LocalWalletConfigDto) -> Future<UInt, Error>
    
    func openWallet(config: LocalWalletConfigDto) -> Future<UInt, Error>
    
    func closeWallet() -> Future<Bool, Error>
}
