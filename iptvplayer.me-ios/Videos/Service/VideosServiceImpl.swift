//
//  VideosServiceImpl.swift
//  iptvplayer.me-ios
//
//  Created by Анатолий on 13.11.2020.
//  Copyright © 2020 Никита. All rights reserved.
//

import Foundation
import Alamofire

class VideosServiceImpl: VideosService {
    
    func getVideoList(onPage page: Int, andWithType type: String, _ completion: @escaping (VideosServiceResponse?, BaseServiceError?) -> Void) -> Request? {
        
        let parameters: Parameters = [
            "page" : page ,
            "type" : type
            //"http_status_codes" : "default"
        ]
        
        let webClient = WebClient<VideosServiceResponse>()
        return webClient.request(path: "/api/json/vod_list", method: .get, parameters: parameters, completion: completion)
    }
    
    func getVideoListWithFilters(withFilterParameters parameters: Parameters, _ completion: @escaping (VideosServiceResponse?, BaseServiceError?) -> Void) -> Request? {
        
        
        let webClient = WebClient<VideosServiceResponse>()
        return webClient.request(path: "/api/json/vod_list", method: .get, parameters: parameters, completion: completion)
    }
}
