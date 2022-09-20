//
//  FlutterRequestAriesSdkStartDto.swift
//  Runner
//
//  Created by Paulo Silva on 15/08/22.
//

import Foundation

class FlutterRequestAriesSdkChannelDto {
    let config: StartAriesSdkConfigDto
    let isToDeleteWallet: Bool?
    
    init(
        config: StartAriesSdkConfigDto,
        isToDeleteWallet: Bool?
    ){
        self.config = config
        self.isToDeleteWallet = isToDeleteWallet
    }
    
    static func from(methodCall: FlutterMethodCall) -> FlutterRequestAriesSdkChannelDto {
        let data = methodCall.arguments as? [String:Bool?]
        return FlutterRequestAriesSdkChannelDto(
            config: StartAriesSdkConfigDto.from(methodCall: methodCall),
            isToDeleteWallet: data?["isToDeleteWallet"] as? Bool
        )
    }
}
