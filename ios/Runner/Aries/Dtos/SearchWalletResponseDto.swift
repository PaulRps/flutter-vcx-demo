//
//  SearchWalletResponseDto.swift
//  Runner
//
//  Created by Paulo Silva on 26/08/22.
//

import Foundation

class SearchWalletResponseDto : ToJson {
    var totalCount: Int?
    var records: Array<SearchRecordDto>?
    
    
    func isEmpty() ->  Bool {
        return (totalCount == nil || totalCount == 0)
    }
    
    func isNotEmpty() -> Bool {
        return !isEmpty()
    }
}
