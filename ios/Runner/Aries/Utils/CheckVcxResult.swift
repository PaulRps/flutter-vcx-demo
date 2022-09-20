//
//  CheckResult.swift
//  Runner
//
//  Created by Paulo Silva on 22/08/22.
//

import Foundation

protocol CheckVcxResult {}

extension CheckVcxResult {
    func isSuccess(_ error: Error?) -> Bool {
        isSuccessCode((error as? NSError)?.code)
    }
    
    func isFail(_ error: Error?) -> Bool {
        !isSuccess(error)
    }
    
    func isSuccessCode(_ code: Int?) -> Bool {
        code == 0
    }
}
