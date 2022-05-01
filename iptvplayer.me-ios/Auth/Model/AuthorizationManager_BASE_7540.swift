//
//  AuthorizationDataModel.swift
//  iptvplayer.me-ios
//
//  Created by Sergey Petrosyan on 11/3/20.
//  Copyright © 2020 Никита. All rights reserved.
//

import Foundation
import Alamofire

protocol AuthorizationManagerlDelegate: class {
    func sendAuthorizationRequest(withParameters: [String: String])
}

class AuthorizationManager: NSObject {
    
    weak var delegate: AuthorizationManagerlDelegate?
    
    func sendAuthorizationRequest(withParameters parameters: [String: String]) {
        let baseURL = "https://iptv.sunduk.tv"
        let endPoint = "/api/json/login"
        
        AF.request(baseURL + endPoint, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).response { (responseData) in
            if let cookie = responseData.response?.value(forHTTPHeaderField: "set-cookie") {
                UserDefaults.standard.setValue(cookie, forKey: "set-cookie")
            }
            self.delegate?.sendAuthorizationRequest(withParameters: parameters)
        }
    }
}
