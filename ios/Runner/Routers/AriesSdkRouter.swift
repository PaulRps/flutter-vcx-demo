//
//  AriesSdkMethodResolver.swift
//  Runner
//
//  Created by Paulo Silva on 15/08/22.
//

import Foundation
import Combine

class AriesSdkRouter: Router {
    typealias I = FlutterRequestAriesSdkChannelDto

    final let input: FlutterRequestAriesSdkChannelDto

    final var routes: [String: AnyPublisher<NativeToFlutterResponseDto, Error>] = [:]

    final var logger = CustomLogger(context: AriesSdkRouter.self)

    private final let startSdkUsecase: StartAriesSdkUsecase
    private final let shutdownSdkUsecase: ShutdownOrResetAriesSdkUsecase

    init(
            input: FlutterRequestAriesSdkChannelDto,
            startSdkUsecase: StartAriesSdkUsecase = StartAriesSdkUsecase(),
            shutdownSdkUsecase: ShutdownOrResetAriesSdkUsecase = ShutdownOrResetAriesSdkUsecase()
    ) {
        self.input = input
        self.startSdkUsecase = startSdkUsecase
        self.shutdownSdkUsecase = shutdownSdkUsecase
        setRoutes()
    }

    private func setRoutes() {

        routes["start"] = startSdkUsecase.start(config: input.config)
        routes["shutdown"] = shutdownSdkUsecase.shutdown(isToDeleteWallet: input.isToDeleteWallet)

    }
}
