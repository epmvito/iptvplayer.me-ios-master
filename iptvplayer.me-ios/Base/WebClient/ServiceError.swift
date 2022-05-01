//
//  ServiceError.swift
//  iptvplayer.me-ios
//
//  Created by Анатолий on 21.10.2020.
//  Copyright © 2020 Никита. All rights reserved.
//

import Foundation
import ObjectMapper

class ServiceError: Mappable {
    
    // MARK: Properties
    
    var status: Bool?
    var message: String?
    var code: Int?
    
    // MARK: Init
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        status  <- map["status"]
        message <- map["error.message"]
        code    <- map["error.code"]
    }
    
}
