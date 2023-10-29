//
//  NetworkError.swift
//  RickAndMorty
//
//  Created by David López on 23/10/23.
//

import Foundation

struct HTTPError: Error {
    
    let status: Int?
    let message: JSON?
    let code: Code
    
    enum Code {
        /// failed json parse
        case couldNotDecode(JSON)
        /// - status: 404
        case notFound
        /// - status: 403
        case forbidden
        /// - status: 401
        case unauthorized
        /// - status: 400
        case badRequest
        /// - status: 406
        case invalid
        /// - status: 5XX
        case internalError
        /// other internal error
        case other(Error)
    }
}

extension HTTPError {
    
    var localizedDescription: JSON? {
        return message
    }
    
    init(status: Int?, message: JSON?) {
        
        self.status = status
        self.message = message
        
        switch status {
        case 400:
            code = .badRequest
        case 401:
            code = .unauthorized
        case 403:
            code = .forbidden
        case 404:
            code = .notFound
        case 406:
            code = .invalid
        default:
            code = .internalError
        }
    }
    
    init(error: Error) {
        
        status = nil
        
        message = [
            "description": error.localizedDescription
        ]
        
        code = .other(error)
    }
}
