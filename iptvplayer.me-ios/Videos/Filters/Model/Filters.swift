//
//  Filters.swift
//  iptvplayer.me-ios
//
//  Created by Анатолий on 17.11.2020.
//  Copyright © 2020 Никита. All rights reserved.
//

import Foundation
import ObjectMapper

class Filters: Mappable {
    
    var filters: [VideosFilter]?
    var selectedString: String?
    
    init (filters: [VideosFilter], selectedString: String) {
        self.filters = filters
        self.selectedString = selectedString
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        filters         <- map["filter"]
        selectedString  <- map["selected_string"]
    }
    
    
}
