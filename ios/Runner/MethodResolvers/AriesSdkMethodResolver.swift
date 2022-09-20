//
//  AriesSdkMethodResolver.swift
//  Runner
//
//  Created by Paulo Silva on 15/08/22.
//

import Foundation
import Combine

class AriesSdkMethodResolver: MethodResolver {
    typealias I = FlutterRequestAriesSdkChannelDto
    
    final let input: FlutterRequestAriesSdkChannelDto
    
    final var routes: [String: AnyPublisher<NativeToFlutterResponseDto, Error>] = [:]
    
    final var logger = CustomLogger(context: AriesSdkMethodResolver.self)
    
    private final let startSdkUsecase: StartAriesSdkUsecase
    private final let shutdownSdkUsecase: ShutdownOrResetAriesSdkUsecase
    
    init(
        input: FlutterRequestAriesSdkChannelDto,
        startSdkUsecase: StartAriesSdkUsecase,
        shutdownSdkUsecase: ShutdownOrResetAriesSdkUsecase
    ) {
        self.input = input
        self.startSdkUsecase = startSdkUsecase
        self.shutdownSdkUsecase = shutdownSdkUsecase
        self.setRoutes()
    }
    
    private func setRoutes() {
        
        self.routes["start"] = self.startSdkUsecase.start(config: self.input.config)
        self.routes["shutdown"] = self.shutdownSdkUsecase.shutdown(isToDeleteWallet: self.input.isToDeleteWallet)
        
    }
}
