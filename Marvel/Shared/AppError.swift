//
//  AppError.swift
//  Marvel
//
//  Created by Mac on 15/06/2023.
//

import Foundation

enum AppError: LocalizedError {
    case decoding
    case network(message: String)
    case unauthenticated
    case offline
    case serverError(message:String)
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .decoding:
            return AppString.Error.general
        case .network(let message):
            return message
        case .unauthenticated:
            return AppString.Error.authentication
        case .offline:
            return AppString.Error.connection
        case .unknown:
            return AppString.Error.general
        case .serverError(let message):
            return message
        }
    }
}
