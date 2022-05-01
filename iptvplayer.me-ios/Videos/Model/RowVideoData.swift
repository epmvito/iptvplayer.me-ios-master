//
//  RowVideoData.swift
//  iptvplayer.me-ios
//
//  Created by Анатолий on 13.11.2020.
//  Copyright © 2020 Никита. All rights reserved.
//

import Foundation
import ObjectMapper

class RowVideoData: Mappable {
    
    // MARK: Public properties
    
    var items:[RowVideoDataItem]?
    
    // MARK: Init
    
    required init?(map: Map) {
        
    }
    
    // MARK: Mapping
    
    func mapping(map: Map) {
        items   <- map["items"]
    }
    
    
    
}


