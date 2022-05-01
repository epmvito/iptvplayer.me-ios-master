//
//  ProviderDataModelItem.swift
//  iptvplayer.me-ios
//
//  Created by Никита on 09.10.2020.
//  Copyright © 2020 Никита. All rights reserved.
//

import Foundation

struct ProviderDataModelItem {
    let name: String
    let api: String
    
    init?(data: [String: String]?) {
        if let data = data, let name = data["name"], let api = data["api"] {
            self.name = name
            self.api = api
        } else {
            return nil
        }
    }
}
