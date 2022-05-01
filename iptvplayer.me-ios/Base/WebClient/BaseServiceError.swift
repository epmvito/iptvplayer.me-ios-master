//
//  BaseServiceError.swift
//  iptvplayer.me-ios
//
//  Created by Анатолий on 21.10.2020.
//  Copyright © 2020 Никита. All rights reserved.
//

import Foundation
import ObjectMapper

enum BaseServiceError: Error {
    case tokenExpired
    case noInternetConnection
    case other
    case custom(String)
}

// MARK: Extensions for Localized Error

extension BaseServiceError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .tokenExpired:
            return "Token expired"
        case .noInternetConnection:
            return "Нет интернет-соединения"
        case .other:
            return "Что-то пошло не так"
        case .custom(let message):
            return message
        }
    }
}

extension BaseServiceError {
    init (jsonString: String) {
        if let error = ServiceError(JSONString: jsonString) {
            self = .custom(error.message ?? "Что-то пошло не так")
        } else {
            self = .other
        }
    }
}
