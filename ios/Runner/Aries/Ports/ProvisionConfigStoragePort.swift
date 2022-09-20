//
//  ProvisionConfigStoragePort.swift
//  Runner
//
//  Created by Paulo Silva on 16/08/22.
//

import Foundation

protocol ProvisionConfigStoragePort: CheckVcxResult {
    func getProvisionData() -> String
    func save(provisionConfig: String?) -> Bool
    func delete() -> Bool
}
