//
//  RowVideoDataItem.swift
//  iptvplayer.me-ios
//
//  Created by Анатолий on 13.11.2020.
//  Copyright © 2020 Никита. All rights reserved.
//

import Foundation
import ObjectMapper

class RowVideoDataItem: Mappable {
    
    // MARK: Public properties
    
    var format: String?
   // var title: String?
    var id: String?
    
    // MARK: Init
    
    required init?(map: Map) {
        
    }
    
    // MARK: Mapping
    
    func mapping(map: Map) {

        format  <- map["format"]
        id    <- map["id"]
       // title <- map["title"]

    }
    
}
