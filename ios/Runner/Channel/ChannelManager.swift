//
//  ChannelManager.swift
//  Runner
//
//  Created by Paulo Silva on 13/08/22.
//

import Foundation
import Flutter


class ChannelManager {
    private final let logger = CustomLogger(context: ChannelManager.self)
    
    final let channels : [Channel]
    
    init(_ channels: [Channel]) {
        self.channels = channels
    }
    
    func registerAll(_ controller : FlutterViewController){
        for channel in channels {
            logger.info(message: "registering listener on channel \(channel.name)")
            channel.listener.register(controller: controller)
        }
    }
}
