//
//  WalletKeyDerivationEnum.swift
//  Runner
//
//  Created by Paulo Silva on 16/08/22.
//

import Foundation

enum WalletKeyDerivationEnum: String, ToJson {
    case RAW
    case ARGON2I_MOD
}

extension WalletKeyDerivationEnum {
    static func from(name: String) -> WalletKeyDerivationEnum? {
        switch name.uppercased() {
        case "RAW":
            return .RAW
        case "ARGON2I_MOD":
            return .ARGON2I_MOD
        default:
            return nil
        }
    }
}
