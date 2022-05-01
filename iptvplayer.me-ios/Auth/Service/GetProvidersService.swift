//
//  GetProvidersService.swift
//  iptvplayer.me-ios
//
//  Created by Анатолий on 21.10.2020.
//  Copyright © 2020 Никита. All rights reserved.
//

import Foundation
import Alamofire

protocol GetProvidersService {
    
    @discardableResult func getProviders(_ completion: @escaping ([ProviderDataModelItem]?, BaseServiceError?) -> Void) -> Request?

    @discardableResult func checkProvider(_ completion: @escaping (BaseResponse?, BaseServiceError?) -> Void) -> Request?

}
