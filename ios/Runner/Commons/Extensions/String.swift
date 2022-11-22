//
// Created by Paulo Pereira on 21/11/22.
//

import Foundation

extension String {
    func encodeBase64() -> String? {
        if let data = data(using: .utf8) {
            return data.base64EncodedString()
        }
        return nil
    }

    func decodeBase64() -> String? {
        if let data = Data(base64Encoded: self, options: .ignoreUnknownCharacters) {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
}
