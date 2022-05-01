//
//  VideoDetailResponse.swift
//  iptvplayer.me-ios
//
//  Created by Анатолий on 23.11.2020.
//  Copyright © 2020 Никита. All rights reserved.
//

import Foundation
import ObjectMapper

class VideoDetailResponse: BaseResponse {
    
    var film: VideoDetail?
        
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        film    <- map ["film"]
    }
}

class VideoFileResponse: BaseResponse {
    
    var film: VideoDetail?
        
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        film    <- map ["film"]
    }
}
