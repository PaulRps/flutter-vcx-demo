//
//  AriesMessageChannelListener.swift
//  Runner
//
//  Created by Paulo Silva on 31/08/22.
//

import Foundation
import Flutter
import Combine

class AriesMessageChannelListener: ChannelListener {
    var channel: ChannelName = .ARIES_MESSAGE
    private var cancellables: Set<AnyCancellable>
    private final let logger = CustomLogger(context: AriesMessageChannelListener.self)

    init() {
        cancellables = Set()
    }

    func callHandler(
            _ call: FlutterMethodCall,
            _ result: @escaping FlutterResult
    ) throws {
        let input = FlutterRequestAriesMessageChannelDto.from(call)

        let method = String(call.method)
        try AriesMessageRouter(
                input: input
        ).call(method: method)?.sink(receiveCompletion: { completion in
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
                            message: "finished call on method \(method) on aries message channel with result: \(res)"
                    )
                    result(res)
                })
                .store(in: &cancellables)
    }
}
