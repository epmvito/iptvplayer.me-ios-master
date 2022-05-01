//
//  VideosService.swift
//  iptvplayer.me-ios
//
//  Created by Анатолий on 13.11.2020.
//  Copyright © 2020 Никита. All rights reserved.
//

import Foundation
import Alamofire

protocol VideosService {
    
    @discardableResult func getVideoList(onPage page: Int, andWithType type: String, _ completion: @escaping (VideosServiceResponse?, BaseServiceError?) -> Void) -> Request?
    
    @discardableResult func getVideoListWithFilters(withFilterParameters parameters: Parameters, _ completion: @escaping (VideosServiceResponse?, BaseServiceError?) -> Void) -> Request?
    
}
