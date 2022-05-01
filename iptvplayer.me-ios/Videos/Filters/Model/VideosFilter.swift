//
//  VideosFilter.swift
//  iptvplayer.me-ios
//
//  Created by Анатолий on 17.11.2020.
//  Copyright © 2020 Никита. All rights reserved.
//

import Foundation
import ObjectMapper

class VideosFilter: Mappable {
    
    var id: String?
    var name: String?
    
    init (id: String, name: String) {
        self.name = name
        self.id = id
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id      <- map["id"]
        name    <- map["name"]
    }
    
    
}
