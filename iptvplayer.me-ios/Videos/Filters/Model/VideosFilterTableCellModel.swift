//
//  VideosFilterTableCellModel.swift
//  iptvplayer.me-ios
//
//  Created by Анатолий on 17.11.2020.
//  Copyright © 2020 Никита. All rights reserved.
//

import Foundation

class VideosFilterTableCellModel: Entity {
    
    var filterName: String
    var selected: String
    
    init (filterName: String, selected: String) {
        self.filterName = filterName
        self.selected = selected
    }
    
}
