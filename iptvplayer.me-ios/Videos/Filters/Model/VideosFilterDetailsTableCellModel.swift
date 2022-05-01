//
//  VideosFilterDetailsTableCellModel.swift
//  iptvplayer.me-ios
//
//  Created by Анатолий on 17.11.2020.
//  Copyright © 2020 Никита. All rights reserved.
//

import Foundation

class VideosFilterDetailsTableCellModel: Entity {
    
    var name: String
    var id: String
    var isSelected: Bool?
    
    init (videosFilter: VideosFilter, isSelected: Bool) {
        self.name = videosFilter.name ?? ""
        self.id = videosFilter.id ?? ""
        self.isSelected = isSelected
    }
    
    init (name: String, id: String) {
        self.name = id
        self.id = id
        self.isSelected = nil
    }
}
