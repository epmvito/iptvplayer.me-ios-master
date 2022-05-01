//
//  Channel.swift
//  iptvplayer.me-ios
//
//  Created by Никита on 18.08.2020.
//  Copyright © 2020 Никита. All rights reserved.
//

import Foundation

struct ProgramsList: Codable {
    let epg: [Program]?
    let servertime: Int?
}

struct Program: Codable {
    let ut_start: Int?
    let ut_stop: Int?
    let progname: String?
    let pdescr: String?
}
