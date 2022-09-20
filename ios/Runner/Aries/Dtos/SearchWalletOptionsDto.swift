//
//  SearchWalletOptionsDto.swift
//  Runner
//
//  Created by Paulo Silva on 26/08/22.
//

import Foundation

class SearchWalletOptionsDto: ToJson {
    var retrieveRecords: Bool? = true
    var retrieveTotalCount: Bool? = true
    var retrieveType: Bool? = false
    var retrieveValue: Bool? = true
    var retrieveTags: Bool? = true
}
