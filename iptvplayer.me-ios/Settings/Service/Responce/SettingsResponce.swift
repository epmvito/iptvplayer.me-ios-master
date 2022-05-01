//
//  SettingsResponce.swift
//  iptvplayer.me-ios
//
//  Created by Ilya Egorov on 17.04.2022.
//  Copyright © 2022 Никита. All rights reserved.
//

import Foundation
import ObjectMapper

class SettingsResponse: BaseResponse {
    
    var film: RowSettings?
        
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        film    <- map ["film"]
    }
}
