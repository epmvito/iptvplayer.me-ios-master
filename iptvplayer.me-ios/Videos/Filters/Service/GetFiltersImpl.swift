//
//  GetFiltersImpl.swift
//  iptvplayer.me-ios
//
//  Created by Анатолий on 17.11.2020.
//  Copyright © 2020 Никита. All rights reserved.
//

import Foundation
import Alamofire

class GetFiltersImpl: GetFiltersService {
    func getFiltersList(withFilterName name: String, _ completion: @escaping (GetFilterResponse?, BaseServiceError?) -> Void) -> Request? {
        
        let parameters: Parameters = [
            "http_status_codes" : "default"
        ]
        
        let webClient = WebClient<GetFilterResponse>()
        return webClient.request(path: "/api/json/vod_\(name)", method: .get, parameters: parameters, completion: completion)
        
    }
}
