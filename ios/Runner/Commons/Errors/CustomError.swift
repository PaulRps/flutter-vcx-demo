//
//  CustomError.swift
//  Runner
//
//  Created by Paulo Silva on 13/08/22.
//

import Foundation

class CustomError : Error {
    final let errorMessage: ErrorMessage;
    
    init(errorMessage: ErrorMessage) {
        self.errorMessage = errorMessage
    }
}
