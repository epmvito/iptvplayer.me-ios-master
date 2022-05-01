//
//  VideoCollectionCellModel.swift
//  iptvplayer.me-ios
//
//  Created by Анатолий on 12.11.2020.
//  Copyright © 2020 Никита. All rights reserved.
//

import Foundation

class VideoCollectionCellModel: Entity {
    
    let name: String
    let image: String
    var isFavorite: Bool
    let id: String
    
    init (rowVideo: RowVideo, isFavorite: Bool = false) {
        self.name = rowVideo.name ?? ""
        self.image = rowVideo.posterUrl ?? ""
//        self.isFavorite = isFavorite
        self.id = rowVideo.id ?? ""
        
        if rowVideo.favourites != nil {
            self.isFavorite = true
        } else {
            self.isFavorite = false
        }
    }
    
//    init (name: String, image: String) {
//        self.name = name
//        self.image = image
//    }
}

