//
//  BaseResponse.swift
//  iptvplayer.me-ios
//
//  Created by Анатолий on 21.10.2020.
//  Copyright © 2020 Никита. All rights reserved.
//

import Foundation
import ObjectMapper

class BaseResponse: Entity, Mappable {
    
    // MARK: Public properties
    
    var status: Bool?
    
    // MARK: Init
    
    init() {
        
    }
    
    // MARK: Mapping
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        status  <- map["status"]
    }
}
