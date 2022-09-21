//
//  ChannelListenr.swift
//  Runner
//
//  Created by Paulo Silva on 13/08/22.
//

import Foundation
import Flutter


protocol ChannelListener {
    var channel: ChannelName {get}
    
    func callHandler(_ call: FlutterMethodCall,_ result: @escaping FlutterResult) throws
}

extension ChannelListener {
    func register(controller : FlutterViewController) {
        let channel = FlutterMethodChannel(name: channel.rawValue, binaryMessenger: controller.binaryMessenger)
        channel.setMethodCallHandler({ (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            self.tryCatch(call, result)
        })
    }
    
    private func tryCatch(_ call: FlutterMethodCall,_ result: @escaping FlutterResult) {
        do {
            try callHandler(call, result)
        } catch let error as CustomError {
            result(
                FlutterError(
                    code: error.errorMessage.data.id,
                    message: error.errorMessage.data.message,
                    details: error.localizedDescription
                )
            )
        } catch {
            result(
                FlutterError(
                    code: ErrorMessage.INTERNAL_ERROR.data.id,
                    message: ErrorMessage.INTERNAL_ERROR.data.message,
                    details: error.localizedDescription
                )
            )
        }
    }
}
