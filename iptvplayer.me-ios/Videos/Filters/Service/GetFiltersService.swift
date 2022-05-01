//
//  GetFiltersService.swift
//  iptvplayer.me-ios
//
//  Created by Анатолий on 17.11.2020.
//  Copyright © 2020 Никита. All rights reserved.
//

import Foundation
import Alamofire

protocol GetFiltersService {
    @discardableResult func getFiltersList(withFilterName name: String, _ completion: @escaping (GetFilterResponse?, BaseServiceError?) -> Void) -> Request?
}
