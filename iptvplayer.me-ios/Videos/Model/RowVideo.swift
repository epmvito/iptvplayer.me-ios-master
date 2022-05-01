//
//  RowVideo.swift
//  iptvplayer.me-ios
//
//  Created by Анатолий on 13.11.2020.
//  Copyright © 2020 Никита. All rights reserved.
//

import Foundation
import ObjectMapper

class RowVideo: Mappable {
    
    // MARK: Public propeties
    
    var id: String?
    var dtModify: String?
    var dtCreate: String?
    var name: String?
    var nameOrig: String?
    var description: String?
    var poster: String?
    var posterUrl: String?
    var year: String?
    var rateIMDB: String?
    var rateKinopoisk: String?
    var country: String?
    var vis: String?
    var viewed: Int?
    var favourites: String?
    var videoData: [RowVideoData]?
    var genre: String?
    var passProtect: String?
    
    // MARK: Init
    
    required init?(map: Map) {
        
    }
    
    // MARK: Mapping
    
    func mapping(map: Map) {
        id              <- map["id"]
        dtModify        <- map["dt_modify"]
        dtCreate        <- map["dt_create"]
        name            <- map["name"]
        nameOrig        <- map["name_orig"]
        description     <- map["description"]
        poster          <- map["poster"]
        posterUrl       <- map["poster_url"]
        year            <- map["year"]
        rateIMDB        <- map["rate_imdb"]
        rateKinopoisk   <- map["rate_kinopoisk"]
        country         <- map["country"]
        vis             <- map["vis"]
        viewed          <- map["viewed"]
        favourites      <- map["favorites"]
        videoData       <- map["video_data"]
        genre           <- map["genre_str"]
        passProtect     <- map["pass_protect"]
    }
    
    
}
