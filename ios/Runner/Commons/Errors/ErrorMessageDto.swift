//
//  ErrorMessageDto.swift
//  Runner
//
//  Created by Paulo Silva on 13/08/22.
//

import Foundation

class ErrorMessageDto: Equatable {
    final let id: String
    final let message: String
    
    init(
        id: String,
        message: String
    ) {
        self.id = id
        self.message = message
    }
    
    static func == (lhs: ErrorMessageDto, rhs: ErrorMessageDto) -> Bool {
        lhs.id == rhs.id
    }
    
    func toMap() -> [String: Any] {
        [
            "id": id,
            "message": message
        ]
    }
}
