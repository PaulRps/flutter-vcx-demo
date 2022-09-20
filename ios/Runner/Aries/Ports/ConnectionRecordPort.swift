//
//  ConnectionRecordPort.swift
//  Runner
//
//  Created by Paulo Silva on 26/08/22.
//

import Foundation
import Combine

protocol ConnectionRecordPort{
    func search(keyValQuery: Array<String>) -> Future<SearchWalletResponseDto,Error>
    
    func save(value: String, tag: ConnectionTagsDto) -> Future<WalletRecordDto?,Error>
    
    func update(record: WalletRecordDto, keyValTag: Array<String>?)-> Future<Int,Error>
    
    func update(
        queryState: ConnectionStateEnum,
        record: WalletRecordDto,
        keyValTag: Array<String>?
    ) -> Future<Int,Error>
    
    func updateTags(
        recordId: String,
        baseJsonTag: String,
        keyValTag: Array<String>?
    )-> Future<Int,Error>
    
    func findConnectionByDid(did: String) -> Future<SearchRecordDto?,Error>
    
    func delete(recordId: String) -> Future<Int,Error>
}
