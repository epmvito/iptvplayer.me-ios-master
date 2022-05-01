//
//  ServerTableCellModel.swift
//  iptvplayer.me-ios
//
//  Created by Анатолий on 03.11.2020.
//  Copyright © 2020 Никита. All rights reserved.
//

import Foundation

class ServerTableCellModel: Entity {
    
    public enum CellStyle {
        case defaultStyle
        case testing
        case successful
        case error
        case slowConnection
    }

    let serverName: String
    let serverURL: String
    var serverInfo: String?
    var speedInfo: Float?
    var progressInfo: Float?
    var cellStyle: CellStyle
    
    init (name: String, serverURL: String, info: String?, speed: Float?, progress: Float?, cellStyle: CellStyle) {
        self.serverName = name
        self.serverURL = serverURL
        self.serverInfo = info
        self.speedInfo = speed
        self.progressInfo = progress
        self.cellStyle = cellStyle
    }
}
