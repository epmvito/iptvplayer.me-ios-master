//
//  VideosServiceResponse.swift
//  iptvplayer.me-ios
//
//  Created by Анатолий on 13.11.2020.
//  Copyright © 2020 Никита. All rights reserved.
//

import Foundation
import ObjectMapper

class VideosServiceResponse: BaseResponse {
    
    // MARK: Public properties
    
    var type: String?
    var total: String?
    var count: Int?
    var page: String?
    var rows: [RowVideo]?
    
    
    // MARK: Mapping
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        type    <- map ["type"]
        total   <- map ["total"]
        count   <- map ["count"]
        page    <- map ["page"]
        rows    <- map ["rows"]
        
    }
    
}
