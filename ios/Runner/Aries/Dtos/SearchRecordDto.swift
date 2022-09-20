//
//  SearchRecordDto.swift
//  Runner
//
//  Created by Paulo Silva on 26/08/22.
//

import Foundation


class SearchRecordDto: ToJson {
    var type: String?
    var id: String?
    var value: String?
    var tags: [String:String]?
    
    enum CodingKeys: String, CodingKey {
        case type, id, value, tags
    }
    
    init(id:String?, type: String?, value: String?, tags: [String:String]?) {
        self.id = id
        self.type = type
        self.value = value
        self.tags = tags
    }
}
