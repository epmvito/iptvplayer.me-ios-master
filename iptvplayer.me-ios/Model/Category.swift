//
//  MoviesCatalog.swift
//  iptvplayer.me-ios
//
//  Created by Никита on 16.08.2020.
//  Copyright © 2020 Никита. All rights reserved.
//

import Foundation

struct Category {
    var isExpanded: Bool
    let category: String
    let channels: [Channel]
}
