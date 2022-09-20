//
//  WalletTagsBuilder.swift
//  Runner
//
//  Created by Paulo Silva on 26/08/22.
//

import Foundation

class WalletTagsBuilder {
    
    class Builder{
        private var tagJson: [String: Any]
        
        init () {
            tagJson =  [String: Any]()
        }
        
        init (_ json : String){
            tagJson =  try! JSONSerialization.jsonObject(with: Data(json.utf8), options: JSONSerialization.ReadingOptions.allowFragments) as! [String: Any]
        }
        
        func encrypted(_ name: String, _ value: String) -> Builder {
            tagJson[name] = value
            return self
        }
        
        func unencrypted(_ name: String, _ value: String) -> Builder {
            tagJson["~\(name)"] = value
            return self
        }
        
        func encrypted(_ tag: Array<String>) -> Builder {
            if (tag.count == 0)||(tag.count % 2 != 0) {
                return self
            }
            
            for index in stride(from: 0, to: tag.count, by: 2){
                _ = self.encrypted(tag[index], tag[index+1])
            }
            
            return self
        }
        
        func unencrypted(_ tag: Array<String>) -> Builder {
            if (tag.count == 0)||(tag.count % 2 != 0) {
                return self
            }
            
            for index in stride(from: 0, to: tag.count, by: 2) {
                _ = self.unencrypted(tag[index], tag[index+1])
            }
            
            return self
        }
        
        func get(_ field: String)-> String {
            tagJson[field] as? String ?? ""
        }
        
        func build() ->  String {
            JsonUtil.toJson(tagJson)
        }
    }
}
