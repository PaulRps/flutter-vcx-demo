//
//  WalletSearchPort.swift
//  Runner
//
//  Created by Paulo Silva on 26/08/22.
//

import Foundation
import Combine

protocol WalletSearchPort {
    func search(query: WalletQueryDto, count: NSInteger) -> Future<SearchWalletResponseDto, Error>
}
