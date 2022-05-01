//
//  NetworkInterceptor.swift
//  iptvplayer.me-ios
//
//  Created by Sergey Petrosyan on 11/5/20.
//  Copyright © 2020 Никита. All rights reserved.
//

import Foundation
import Alamofire

class NetworkInterceptor: Interceptor {
    
    private let authManager = AuthorizationManager()
    private let retryLimit = 3
    
    private func getCookiesFromUserDefaults() -> [String]? {
        if let cookies = UserDefaults.standard.value(forKey: "set-cookie") as? [String] {
            return cookies
        } else {
            return nil
        }
    }
    
    override func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        guard let cookies = getCookiesFromUserDefaults() else { return }
        var adaptedRequest = urlRequest
        for cookie in cookies {
            adaptedRequest.setValue(cookie, forHTTPHeaderField: "Cookie")
        }
        completion(.success(adaptedRequest))
    }
    
    override func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        if let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 {
            // If still error after 3 retries, then we show error to the user
            if (request.retryCount < retryLimit) {
                print("retry the failed request with new token")
                //TODO: Send another authorization request.
            } else {
                completion(.doNotRetry)
            }
        } else {
            completion(.doNotRetry)
        }
    }
}
