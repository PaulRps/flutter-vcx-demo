//
//  Logger.swift
//  Runner
//
//  Created by Paulo Silva on 14/08/22.
//

import Foundation
import os.log

extension OSLog {
    private static var subsystem = Bundle.main.bundleIdentifier!
    
    static func custom(ctx: String) -> OSLog {return OSLog(subsystem: subsystem, category: "\(subsystem).\(ctx)")}
}

class CustomLogger {
    private let context: String
    private let osLog: OSLog
    
    init(context: Any.Type) {
        self.context = String(describing: context.self)
        self.osLog = OSLog.custom(ctx: self.context)
    }
    
    func info(message: String) {
        os_log("%@", log: self.osLog, type: .info, message)
    }
    
    func debug(message: String) {
        os_log("%@", log: self.osLog, type: .debug, message)
    }
    
    func error(message: String) {
        os_log("%@", log: self.osLog, type: .error, message)
    }
    
}





