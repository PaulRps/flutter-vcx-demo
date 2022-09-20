//
//  Jsonable.swift
//  Runner
//
//  Created by Paulo Silva on 14/08/22.
//

import Foundation

protocol ToJson: Codable {}

extension ToJson {
    func toJson() -> String {
        return JsonUtil.toJson(self)
    }
}
