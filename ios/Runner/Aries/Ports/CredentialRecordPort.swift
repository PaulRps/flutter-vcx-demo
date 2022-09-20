//
// Created by Paulo Silva on 05/09/22.
//

import Foundation
import Combine

protocol CredentialRecordPort {
    func save(value: String, tag: WalletTagsBuilder.Builder, id: String?) -> Future<WalletRecordDto?, Error>

    func updateTags(uid: String, newTags: WalletTagsBuilder.Builder) -> Future<Int, Error>

    func search(_ keyValQuery: Array<String>) -> Future<SearchWalletResponseDto, Error>
}