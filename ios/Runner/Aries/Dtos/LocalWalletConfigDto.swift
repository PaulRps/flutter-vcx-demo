//
//  WalletConfigDto.swift
//  Runner
//
//  Created by Paulo Silva on 16/08/22.
//

import Foundation

class LocalWalletConfigDto: ToJson {
    
    final let walletName: String?
    
    final let walletKey: String?
    
    final let walletKeyDerivation: WalletKeyDerivationEnum?
    
    init(
        walletName: String?="",
        walletKey: String?="",
        walletKeyDerivation: WalletKeyDerivationEnum? = .ARGON2I_MOD
    ){
        self.walletName = walletName
        self.walletKey = walletKey
        self.walletKeyDerivation = walletKeyDerivation
    }
    
    enum CodingKeys: String, CodingKey {
        case walletName = "wallet_name"
        case walletKey = "wallet_key"
        case walletKeyDerivation = "wallet_key_derivation"
    }
    
    static func from(localWalletConfig: [String:AnyObject]?) -> LocalWalletConfigDto {
        return LocalWalletConfigDto(
            walletName: localWalletConfig?["walletName"] as? String,
            walletKey: localWalletConfig?["walletKey"] as? String,
            walletKeyDerivation: WalletKeyDerivationEnum.from(
                name: localWalletConfig?["walletKeyDerivation"] as? String ?? ""
            )
        )
    }
    
}
