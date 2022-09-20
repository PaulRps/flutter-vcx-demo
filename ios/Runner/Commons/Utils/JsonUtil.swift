//
//  JsonUtils.swift
//  Runner
//
//  Created by Paulo Silva on 14/08/22.
//

import Foundation

class JsonUtil {
    private static let logger = CustomLogger(context: JsonUtil.self)

    static func toJson<T: Encodable>(_ obj: T) -> String {
        var json = ""
        do {
            let jsonData = try JSONEncoder().encode(obj)
            json = String(data: jsonData, encoding: .utf8)!
        } catch let e {
            JsonUtil.logger.error(message: "error on encoding object to JSON: \(e.localizedDescription)")
        }
        return json
    }

    static func toJson(_ map: [String: Any]) -> String {
        let invalidJson = ""
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: map, options: [])
            return String(bytes: jsonData, encoding: String.Encoding.utf8) ?? invalidJson
        } catch let e {
            JsonUtil.logger.error(message: "error on encoding map to JSON \(e.localizedDescription)")
        }
        return invalidJson
    }

    static func toJson(_ object: Any?) -> String {
        guard let data = try? JSONSerialization.data(withJSONObject: object, options: []) else {
            return ""
        }
        return String(data: data, encoding: String.Encoding.utf8) ?? ""
    }

    static func fromJson<T: Codable>(_ json: String, _ type: T.Type) -> T? {
        do {
            return try JSONDecoder().decode(type, from: json.data(using: .utf8)!)
        } catch let e {
            JsonUtil.logger.error(message: "error on dencoding JSON to object: \(e.localizedDescription)")
            return nil
        }
    }

    static func fromDictionary<T: Codable>(_ dict: [String: Any], _ type: T.Type) -> T? {
        var obj: T?
        let json = JsonUtil.toJson(dict)
        obj = JsonUtil.fromJson(json, type)
        return obj
    }

    static func toDictionary(_ json: String) -> [String: AnyObject]? {
        if let data = json.data(using: .utf8) {
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: AnyObject]
                return json
            } catch let e {
                JsonUtil.logger.error(message: "error on converting json to dictionary: \(e.localizedDescription)")
            }
        }
        return nil
    }

    static func fromData<T: Codable>(_ data: Data?, _ type: T.Type) -> T? {
        if let data = data {
            do {
                let object = try JSONDecoder().decode(type, from: data)
                return object
            } catch let e {
                JsonUtil.logger.error(message: "error on converting json to dictionary: \(e.localizedDescription)")
            }
        }
        return nil
    }

    static func toType<T>(_ json: String, _ type: T.Type) -> T? {
        if let data = json.data(using: .utf8) {
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? T
                return json
            } catch let e {
                JsonUtil.logger.error(message: "error on converting json to dictionary: \(e.localizedDescription)")
            }
        }
        return nil
    }

}
