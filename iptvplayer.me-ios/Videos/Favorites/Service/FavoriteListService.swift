//
//  GetFavoriteListService.swift
//  iptvplayer.me-ios
//
//  Created by Анатолий on 23.11.2020.
//  Copyright © 2020 Никита. All rights reserved.
//

import Foundation
import Alamofire

protocol FavoriteListService {
    @discardableResult func getFavoritesList(_ completion: @escaping (VideosServiceResponse?, BaseServiceError?) -> Void) -> Request?
    
    @discardableResult func addFavorite(withID id: String, _ completion: @escaping (BaseResponse?, BaseServiceError?) -> Void) -> Request?
    
    @discardableResult func deleteFavorite(withID id: String, _ completion: @escaping (BaseResponse?, BaseServiceError?) -> Void) -> Request?
    
}
