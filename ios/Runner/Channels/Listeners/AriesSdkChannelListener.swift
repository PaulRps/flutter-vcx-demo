//
//  AriesSdkChannelListener.swift
//  Runner
//
//  Created by Paulo Silva on 13/08/22.
//

import Foundation
import Combine
import Flutter

class AriesSdkChannelListener: ChannelListener {
    var channel: ChannelName = .ARIES_SDK

    private var cancellables: Set<AnyCancellable>
    private let logger = CustomLogger(context: AriesSdkChannelListener.self)

    init() {
        cancellables = Set()
    }

    func callHandler(
            _ call: FlutterMethodCall,
            _ result: @escaping FlutterResult
    ) throws {
        let input = FlutterRequestAriesSdkChannelDto.from(methodCall: call)

        let resolver = AriesSdkMethodResolver(
                input: input,
                startSdkUsecase: StartAriesSdkUsecase(),
                shutdownSdkUsecase: ShutdownOrResetAriesSdkUsecase()
        )

        let method = String(call.method)

        try resolver.call(method: method)?.sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished: break
                    case .failure(let error):
                        self.logger.error(message: error.localizedDescription)
                        result(
                                FlutterError(
                                        code: ErrorMessage.INTERNAL_ERROR.data.id,
                                        message: ErrorMessage.INTERNAL_ERROR.data.message,
                                        details: error.localizedDescription
                                )
                        )
                    }
                }, receiveValue: { response in
                    let res = response.toMap()
                    self.logger.info(
                            message: "finished call on method \(method) on aries sdk channel with result: \(res)"
                    )
                    result(res)
                })
                .store(in: &cancellables)
    }
}
