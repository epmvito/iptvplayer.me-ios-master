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
    
    func sendAuthorizationRequest(withParameters parameters: [String: String], completion: @escaping (HTTPURLResponse) -> ()) {
        let baseURL = "https://iptv.sunduk.tv"
        let endPoint = "/api/json/login"
        
        AF.request(baseURL + endPoint, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).response { (responseData) in
            if let response = responseData.response, let login = parameters["login"], let password = parameters["pass"] {
                let userDefaults = UserDefaults.standard
                var cookies = [String]()
                if let headers: HTTPHeaders = responseData.response?.headers {
                    for header in headers {
                        if header.name == "Set-Cookie" {
                            cookies.append(header.value)
                        }
                    }
                }
                
                completion(response)
                if response.statusCode == 200 {
                    userDefaults.setValue(cookies, forKey: "set-cookie")
                    userDefaults.setValue(login, forKey: "login")
                    userDefaults.setValue(password, forKey: "pass")
                }
            }
            self.delegate?.sendAuthorizationRequest(withParameters: parameters)
        }
    }
}
