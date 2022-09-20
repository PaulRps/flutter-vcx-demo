//
//  WalletQueryDto.swift
//  Runner
//
//  Created by Paulo Silva on 26/08/22.
//

import Foundation

class WalletQueryDto: ToJson{
    var type: String?
    var json: String?
    var optionsTag: SearchWalletOptionsDto?
    
    init (
        type:String?,
        json:String="{}",
        optionsTag: SearchWalletOptionsDto = SearchWalletOptionsDto()
    ){
        self.type = type
        self.json = json
        self.optionsTag = optionsTag
    }
}
