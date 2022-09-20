//
//  WalletRecordPort.swift
//  Runner
//
//  Created by Paulo Silva on 26/08/22.
//

import Foundation
import Combine

protocol WalletRecordPort {
    func add(record: WalletRecordDto) -> Future<Int,Error>
    func update(record: WalletRecordDto)-> Future<Int,Error>
    func updateTags(record: WalletRecordDto)-> Future<Int,Error>
    func deleteRecord(type: WalletRecordTypeEnum, uuid: String) -> Future<Int,Error>
}
