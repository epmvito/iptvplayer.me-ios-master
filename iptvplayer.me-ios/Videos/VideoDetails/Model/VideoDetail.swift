//
//  VideoDetail.swift
//  iptvplayer.me-ios
//
//  Created by Анатолий on 23.11.2020.
//  Copyright © 2020 Никита. All rights reserved.
//

import Foundation
import ObjectMapper


class VideoDetail: Mappable {
    // MARK: Public propeties
           
    var id: String?
    var name: String?
    var nameOrig: String?
    var description: String?
    var poster: String?
    var posterUrl: String?
    var lenght: Double?
    var genre: String?
    var year: String?
    var director: String?
    var scenario: String?
    var actors: String?
    var rateIMDB: String?
    var rateKinopoisk: String?
    var rateMpaa: String?
    var country: String?
    var studio: String?
    var awards: String?
    var budget: String?
    var images: String?
    var viewed: Int?
    var favourites: String?
    var videos: [RowVideoDataItem]?
           
    
    // MARK: Init
    
    required init?(map: Map) {
          
      }
           
    // MARK: Mapping
           
    func mapping(map: Map) {
        id              <- map["id"]
        name            <- map["name"]
        nameOrig        <- map["name_orig"]
        description     <- map["description"]
        poster          <- map["poster"]
        posterUrl       <- map["poster_url"]
        lenght          <- map["lenght"]
        genre           <- map["genre_str"]
        year            <- map["year"]
        director        <- map["director"]
        scenario        <- map["scenario"]
        actors          <- map["actors"]
        rateIMDB        <- map["rate_imdb"]
        rateKinopoisk   <- map["rate_kinopoisk"]
        rateMpaa        <- map["rate_mpaa"]
        country         <- map["country"]
        studio          <- map["studio"]
        awards          <- map["awards"]
        budget          <- map["budget"]
        images          <- map["images"]
        viewed          <- map["viewed"]
        favourites      <- map["favorites"]
        videos          <- map["videos"]
    }
}
