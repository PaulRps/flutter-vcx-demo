//
//  WalletRecordDto.swift
//  Runner
//
//  Created by Paulo Silva on 26/08/22.
//

import Foundation

class WalletRecordDto: ToJson {
    var type: WalletRecordTypeEnum
    var uuid: String
    var value: String?
    var tag: String?

    init(type: WalletRecordTypeEnum, uuid: String, value: String? = "", tag: String) {
        self.type = type
        self.uuid = uuid
        self.value = value
        self.tag = tag
    }

    static func from(_ record: SearchRecordDto) -> WalletRecordDto {
        WalletRecordDto(
                type: WalletRecordTypeEnum.getOne(record.type!),
                uuid: record.id!,
                value: record.value,
                tag: JsonUtil.toJson(record.tags)
        )
    }
}
