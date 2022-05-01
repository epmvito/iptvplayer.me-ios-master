//
//  RowSettings.swift
//  iptvplayer.me-ios
//
//  Created by Ilya Egorov on 17.04.2022.
//  Copyright © 2022 Никита. All rights reserved.
//

import Foundation
import ObjectMapper

class RowSettings: Mappable {
    
    var timeshift: String?
    var timezone: String?
    var bitrate: String?
    var bitratehd: String?
    var vod_bitrate: String?
    var stream_server: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {

        timezone  <- map["timezone"]
        timeshift    <- map["timeshift"]
        bitrate    <- map["bitrate"]
        bitratehd    <- map["bitratehd"]
        vod_bitrate    <- map["vod_bitrate"]
        stream_server    <- map["stream_server"]
    }
    
}
