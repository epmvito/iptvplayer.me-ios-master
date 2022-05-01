//
//  ServersTestingImpl.swift
//  iptvplayer.me-ios
//
//  Created by Анатолий on 11.11.2020.
//  Copyright © 2020 Никита. All rights reserved.
//

import Foundation
import Alamofire

class ServersSettingsImpl: ServersSettingsService {

    func setStreamServer(withVal val: String, andVar vAr: String?, _ completion: @escaping (BaseResponse?, BaseServiceError?) -> Void) -> Request? {
        
        
        let parameters: Parameters = [
            "var" : vAr ?? "stream_server" ,
            "val" : val,
            "http_status_codes" : "default"
        ]
        
    
        let webClient = WebClient<BaseResponse>()
        return webClient.request(path: "/api/json/settings_set", method: .get, parameters: parameters, completion: completion)
    }
    
    func StreamServer(andVar vAr: String, _ completion: @escaping (BaseResponse?, BaseServiceError?) -> Void) -> Request? {
        
        
        let parameters: Parameters = [
            "servername" : vAr
        ]
        
    
        let webClient = WebClient<BaseResponse>()
        return webClient.request(path: "/api/json/speedtest", method: .get, parameters: parameters, completion: completion)
    }
}
