//
//  ProvisionConfigStorageAdapter.swift
//  Runner
//
//  Created by Paulo Silva on 16/08/22.
//

import Foundation
import Security

class ProvisionConfigStorageAdapter: ProvisionConfigStoragePort {
    
    private static let CONFIG:String = "provision_config"
    private static let FIRST_RUN:String = "first_run"
    private static let SERVICE:String = Bundle.main.bundleIdentifier!
    private final let logger = CustomLogger(context: ProvisionConfigStorageAdapter.self)
    
    func getProvisionData() -> String {
        
        logger.info(message: "getting stored provision config")
        
        var query = keyChainQuery()
        
        query[kSecMatchLimit as String] = kSecMatchLimitOne
        query[kSecReturnData as String] = kCFBooleanTrue
        
        var itemCopy: AnyObject?
        let status = SecItemCopyMatching(
            query as CFDictionary,
            &itemCopy
        )
        
        guard status != errSecItemNotFound else {
            //throw KeychainError.itemNotFound
            logger.info(message: "stored provision config not found")
            return ""
        }
        
        guard status == errSecSuccess else {
            //throw KeychainError.unexpectedStatus(status)
            logger.error(message: "error on getting stored provision config")
            return ""
        }
        
        var provision = ""
        if (itemCopy as? Data)?.isEmpty == false {
            provision = String(data: (itemCopy as! Data), encoding: .utf8)!
        }
        
        if (isFirstRun() && !provision.isEmpty) {
            _ = delete()
            provision = ""
        }
        
        logger.info(message: "finished get stored provision config success=\(!provision.isEmpty)")
        
        return provision
    }
    
    func save(provisionConfig: String?) -> Bool {
        logger.info(message: "saving stored provision config")
        
        guard provisionConfig?.isEmpty == false else {
            return false
        }
        
        let query = keyChainQuery(
            data: provisionConfig
        )
        
        let status = SecItemAdd(
            query as CFDictionary,
            nil
        )
        
        if status == errSecDuplicateItem {
            logger.error(message: "error on saving stored provision config")
//            throw KeychainError.duplicateItem
            return false
        }
        
        guard status == errSecSuccess else {
            logger.error(message: "error on saving stored provision config")
//            throw KeychainError.unexpectedStatus(status)
            return false
        }
        
        logger.info(message: "saved stored provision config successfully")
        
        setFirstRun()
        
        return true
    }
    
    func delete() -> Bool {
        
        logger.info(message: "deleting stored provision config")
        
        let query = keyChainQuery()
        
        let status = SecItemDelete(query as CFDictionary)
        
        guard status == errSecSuccess else {
            logger.error(message: "error on deleting stored provision config")
//            throw KeychainError.unexpectedStatus(status)
            return false
        }
        
        logger.info(message: "deleted stored provision config successfully")
        return true
    }
    
    private func keyChainQuery(data: String?=nil) -> [String:Any] {
        var query:[String:Any] = [
            kSecAttrService as String: ProvisionConfigStorageAdapter.SERVICE,
            kSecAttrAccount as String: ProvisionConfigStorageAdapter.CONFIG,
            kSecClass as String: kSecClassGenericPassword
        ]
        
        if (data?.isEmpty == false) {
            query[kSecValueData as String] = Data(data!.utf8)
        }
        
        return query
    }
    
    private func isFirstRun() -> Bool {
        UserDefaults.standard.string(forKey: ProvisionConfigStorageAdapter.FIRST_RUN) == nil
    }
    
    private func setFirstRun() {
        UserDefaults.standard.set("ran", forKey: ProvisionConfigStorageAdapter.FIRST_RUN)
    }
    
    enum KeychainError: Error {
        case itemNotFound
        case duplicateItem
        case invalidItemFormat
        case unexpectedStatus(OSStatus)
    }
}
