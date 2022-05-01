//
//  GetProvidersServiceImpl.swift
//  iptvplayer.me-ios
//
//  Created by Анатолий on 21.10.2020.
//  Copyright © 2020 Никита. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire

class GetProvidersServiceImpl: GetProvidersService {
    
    func checkProvider(_ completion: @escaping (BaseResponse?, BaseServiceError?) -> Void) -> Request? {
        
        let webClient = WebClient<BaseResponse>()
        return webClient.request(path: "/api/json/epg", completion: completion)
    }
    
    func getProviders(_ completion: @escaping ([ProviderDataModelItem]?, BaseServiceError?) -> Void) -> Request? {
        
        let webClient = WebClient<BaseResponse>()
        return webClient.providersRequest(completion: completion)
    }

    func testMethod(url: String, _ completion: @escaping (BaseResponse?, BaseServiceError?) -> Void) -> Request? {
        // вместо base response прописываешь класс наследованный от BaseResponse, пример такого я скину
        let headers: HTTPHeaders = [ // Хедеры в основном для авторизации
            "" : ""
        ]
        
        let parameters: Parameters = [ // параметры которые нужно передать запрос(они в запросе пишутся после знака ?)
            "" : ""
        ]
        
        let webClient = WebClient<BaseResponse>(baseUrl: url) // твоя ссылка прописывается здесь
        
        return webClient.request(path: "", method: .get, parameters: parameters, headers: headers, completion: completion) // в path прописывается то что идет после основной ссылки и до знака ?
    }
    
}
