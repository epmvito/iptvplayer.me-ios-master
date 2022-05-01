//
//  ChannelsList.swift
//  iptvplayer.me-ios
//
//  Created by Sergey Petrosyan on 11/9/20.
//  Copyright © 2020 Никита. All rights reserved.
//

import Foundation

struct ChannelsList: Codable {
    let groups: [Group]?
    let servertime: Int?
}

struct Group: Codable {
    let id: String?
    let name: String?
    let color: String?
    let channels: [Channel]?
}

struct Channel: Codable {
    let id: String?
    let name: String?
    let stream_params: [StreamParameter]?
    let is_video: String?
    let need_bandwidth: String?
    let protected: Int?
    let have_archive: Int?
    let icon: String?
    let icon_url: String?
    let epg_progname: String?
    let epg_start: String?
    let epg_end: String?
    let hide: String?
    let ac3_audio: Int?
}

struct StreamParameter: Codable {
    let rate: String?
    let ts: String?
}
