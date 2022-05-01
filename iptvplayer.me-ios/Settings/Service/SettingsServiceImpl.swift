//
//  SettingsService.swift
//  iptvplayer.me-ios
//
//  Created by Ilya Egorov on 17.04.2022.
//  Copyright © 2022 Никита. All rights reserved.
//

import Foundation
import Alamofire

class SettingsServiceImpl: SettingsService{
    
    func setSettings(withVal val: String, andVar vAr: String, _ completion: @escaping (BaseResponse?, BaseServiceError?) -> Void) -> Request? {
        
        
        let parameters: Parameters = [
            "var" : vAr,
            "val" : val,
//            "http_status_codes" : "default"
        ]
        
    
        let webClient = WebClient<BaseResponse>()
        return webClient.request(path: "/api/json/settings", method: .get, parameters: parameters, completion: completion)
    }
}
