//
//  GetFilterResponse.swift
//  iptvplayer.me-ios
//
//  Created by Анатолий on 17.11.2020.
//  Copyright © 2020 Никита. All rights reserved.
//

import Foundation
import ObjectMapper

class GetFilterResponse: BaseResponse {
    
    var types: [VideosFilter]?
    var genres: [VideosFilter]?
    var years: [VideosFilter]?
    var kinopoisk: [VideosFilter]?
    var imdb: [VideosFilter]?
    
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        types       <- map["types"]
        genres      <- map["genres"]
        years       <- map["years"]
        kinopoisk   <- map["kinopoisk"]
        imdb        <- map["imdb"]
        
    }
    
}
