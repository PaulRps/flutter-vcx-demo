//
//  DateUtil.swift
//  Runner
//
//  Created by Paulo Silva on 31/08/22.
//

import Foundation

class DateUtil {
    static func currentDateTime() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter.string(from: Date())
    }
}
