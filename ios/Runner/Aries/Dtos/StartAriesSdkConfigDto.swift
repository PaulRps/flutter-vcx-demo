//
//  StartAriesSdkConfig.swift
//  Runner
//
//  Created by Paulo Silva on 15/08/22.
//

import Foundation
import Flutter

class StartAriesSdkConfigDto {
    let provision: ProvisionAgencyConfigDto?
    let initThreadPoolConfig: InitThreadPoolConfigDto?
    let openMainPoolConfig: OpenPoolConfigDto?
    let localWalletConfig: LocalWalletConfigDto?
    let logLevel: AriesSdkLogLevelEnum?
    
    init(
        provision: ProvisionAgencyConfigDto?,
        initThreadPoolConfig: InitThreadPoolConfigDto?,
        openMainPoolConfig: OpenPoolConfigDto?,
        localWalletConfig: LocalWalletConfigDto?,
        logLevel: AriesSdkLogLevelEnum?
    ){
        self.provision = provision
        self.initThreadPoolConfig = initThreadPoolConfig
        self.openMainPoolConfig = openMainPoolConfig
        self.localWalletConfig = localWalletConfig
        self.logLevel = logLevel
    }
    
    
    static func from(methodCall: FlutterMethodCall) -> StartAriesSdkConfigDto {
        let data = methodCall.arguments as? [String:AnyObject]
        let config = data?["config"] as? [String:AnyObject]
        
        return StartAriesSdkConfigDto(
            provision: ProvisionAgencyConfigDto.from(
                provisionConfig: config?["provisionConfig"] as? [String:AnyObject]
            ),
            initThreadPoolConfig: InitThreadPoolConfigDto.from(
                initThreadPoolConfig: config?["initThreadPoolConfig"] as? [String:AnyObject]
            ),
            openMainPoolConfig: OpenPoolConfigDto.from(
                openMainPoolConfig: config?["openMainPoolConfig"] as? [String:AnyObject]
            ),
            localWalletConfig: LocalWalletConfigDto.from(
                localWalletConfig: config?["localWalletConfig"] as? [String:AnyObject]
            ),
            logLevel: AriesSdkLogLevelEnum.from(level: config?["logLevel"] as? String)
        )
    }
}
