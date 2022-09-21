//
//  MethodResolver.swift
//  Runner
//
//  Created by Paulo Silva on 15/08/22.
//

import Foundation
import Combine

protocol Router {
    associatedtype I

    var input: I { get }
    var routes: [String: AnyPublisher<NativeToFlutterResponseDto, Error>] { get }
    var logger: CustomLogger { get }
}

extension Router {
    func call(method: String) throws -> AnyPublisher<NativeToFlutterResponseDto, Error>? {
        logger.info(message: "resolving method call: \(method)")

        let methodCall = routes[method]
        if methodCall == nil {
            logger.error(message: "method call: \(method) does not exist")
            throw CustomError(errorMessage: .INTERNAL_ERROR)
        }

        return methodCall
    }
}
