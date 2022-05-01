//
//  GetFavoriteListServiceImpl.swift
//  iptvplayer.me-ios
//
//  Created by Анатолий on 23.11.2020.
//  Copyright © 2020 Никита. All rights reserved.
//

import Foundation
import Alamofire

class FavoriteListServiceImpl: FavoriteListService {
    
    func addFavorite(withID id: String, _ completion: @escaping (BaseResponse?, BaseServiceError?) -> Void) -> Request? {
        
        let parameters: Parameters = [
            "id" : id,
            "http_status_codes" : "default"
        ]
        
        let webClient = WebClient<VideosServiceResponse>()
        return webClient.request(path: "/api/json/vod_favadd", method: .get, parameters: parameters, completion: completion)
    }
    
    func deleteFavorite(withID id: String, _ completion: @escaping (BaseResponse?, BaseServiceError?) -> Void) -> Request? {
        
        let parameters: Parameters = [
            "id" : id,
            "http_status_codes" : "default"
        ]
        
        let webClient = WebClient<VideosServiceResponse>()
        return webClient.request(path: "/api/json/vod_favsub", method: .get, parameters: parameters, completion: completion)
    }
    
    func getFavoritesList(_ completion: @escaping (VideosServiceResponse?, BaseServiceError?) -> Void) -> Request? {
        
        let parameters: Parameters = [
            "http_status_codes" : "default"
        ]
        
        let webClient = WebClient<VideosServiceResponse>()
        return webClient.request(path: "/api/json/vod_favlist", method: .get, parameters: parameters, completion: completion)
    }
}
