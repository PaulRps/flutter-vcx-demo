//
//  AriesWalletRepository.swift
//  Runner
//
//  Created by Paulo Silva on 30/08/22.
//

import Foundation
import Combine

class AriesWalletRepository {
    
    private final let walletManager: WalletManagerPort
    
    init(
        walletManager: WalletManagerPort=LocalWalletManagerAdapter()
    ) {
        self.walletManager = walletManager
    }
    
    func createWallet(config: LocalWalletConfigDto) -> Future<Int, Error> {
        return self.walletManager.createWallet(config: config)
    }
    
    func openWallet(config: LocalWalletConfigDto) -> Future<Int, Error> {
        return self.walletManager.openWallet(config: config)
    }
    
    func closeWallet() -> Future<Bool, Error> {
        return self.walletManager.closeWallet()
    }

}
