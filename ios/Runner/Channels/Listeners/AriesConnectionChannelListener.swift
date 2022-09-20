//
//  AriesConnectionChannelListener.swift
//  Runner
//
//  Created by Paulo Silva on 26/08/22.
//

import Foundation
import Combine
import Flutter

class AriesConnectionChannelListener: ChannelListener {
    var channel: ChannelName = .ARIES_CONNECTION

    private var cancellables: Set<AnyCancellable>
    private let logger = CustomLogger(context: AriesConnectionChannelListener.self)

    init() {
        cancellables = Set()
    }

    func callHandler(
            _ call: FlutterMethodCall,
            _ result: @escaping FlutterResult
    ) throws {
        let input = FlutterRequestAriesConnectionChannelDto.from(call: call)

        let resolver = AriesConnectionMethodResolver(
                input: input,
                createOrRecreateConnectionUsecase: ConnectOrReconnectAriesConnectionUsecase()
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
                    self.logger.info(message: "finished call on method \(method) on aries connection channel with result: \(res)")
                    result(res)
                })
                .store(in: &cancellables)
    }

}
