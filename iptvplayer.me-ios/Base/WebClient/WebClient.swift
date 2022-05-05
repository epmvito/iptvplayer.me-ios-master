//
//  WebClient.swift
//  iptvplayer.me-ios
//
//  Created by Анатолий on 21.10.2020.
//  Copyright © 2020 Никита. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

final class WebClient<T: BaseMappable> {
    
    // MARK: Properties
    
    let baseUrl: String
    private var acceptableStatusCodes: [Int] {return Array(200..<501) }
    
    // MARK: Init
    
    init() {
        if let saveUrl = UserDefaults.standard.string(forKey: "providerAPI") {
            self.baseUrl = saveUrl
        } else {
            self.baseUrl = "https://api.iptvplayer.me"
        }
    }
    
    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    // MARK: Public methods
    
    @discardableResult
    func  providersRequest(path: String = "https://api.iptvplayer.me/get_companies_list/?http_status_codes=default", method: HTTPMethod = .get, parameters: Parameters? = nil, encoding: ParameterEncoding = URLEncoding.default, headers: HTTPHeaders? = nil, completion: @escaping ([ProviderDataModelItem]?, BaseServiceError?) -> Void) -> Request? {
        
        return AlamofireSessionManager.request(path, method: method, parameters: parameters, encoding: encoding, headers: headers)
            .responseJSON { response in
//                debugPrint("Request Info: \(response.request!)")
//                debugPrint("Response Info: \(response)")
                
                switch response.result {
                case .success:
                    if response.response?.statusCode != 200 {
                        if response.response?.statusCode == 401 {
                            completion(nil, BaseServiceError.tokenExpired)
                        }
                        else {
                            if let result = response.value {
                                completion(nil, BaseServiceError(jsonString: result as! String))
                            }
                            else {
                                completion(nil, BaseServiceError.noInternetConnection)
                            }
                        }
                    }
                    else {
                        if let value = response.value as? [AnyObject] {
                            var providers = [ProviderDataModelItem]()
                            for item in value {
                                if let providerDataModelItem = ProviderDataModelItem(data: item as? [String: String]) {
                                    providers.append(providerDataModelItem)
                                }
                            }
                            completion(providers, nil)
                        } else {
                            completion(nil, BaseServiceError.other)
                        }
                    }
                case .failure( _):
                    completion(nil, BaseServiceError.noInternetConnection)
                }
            }
        }
    
    @discardableResult
    func request(path: String, method: HTTPMethod = .get, parameters: Parameters? = nil, encoding: ParameterEncoding = URLEncoding.default, headers: HTTPHeaders? = nil, completion: @escaping (T?, BaseServiceError?) -> Void) -> Request? {
        let url = baseUrl + path
        
        return AlamofireSessionManager.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers)
            .validate(statusCode: acceptableStatusCodes)
            .validate(contentType: ["application/json"])
            .responseString { response in
//                debugPrint("Request Info: \(response.request)")
//                debugPrint("Response Info: \(response)")
                
                switch response.result {
                case .success:
                    if response.response?.statusCode != 200 {
                        if response.response?.statusCode == 401 {
                            completion(nil, BaseServiceError.tokenExpired)
                        }
                        else {
                            if let result = response.value {
                                completion(nil, BaseServiceError(jsonString: result))
                            }
                            else {
                                completion(nil, BaseServiceError.noInternetConnection)
                            }
                        }
                    }
                    else {
                        if let resultString = response.value,
                            let result = Mapper<T>().map(JSONString: resultString) {
                            
                            completion(result, nil)
                        }
                        else {
                            completion(nil, BaseServiceError.other)
                        }
                    }
                case .failure( _):
                    completion(nil, BaseServiceError.noInternetConnection)
                }
            }
        }
    
    /// Request list of channels from the API.
    /// "/api/json/channel_list&http_status_codes=default"
    /// - Parameter completion: completion handler
    func requestChannelsList(completion: ((ChannelsList) -> Void)? = nil) {
        let endPoint = "/api/json/channel_list"
        let interceptor = NetworkInterceptor()
        AF.request(baseUrl + endPoint, method: .get, parameters: nil, headers: nil, interceptor: interceptor).response { responseData in
            guard let data = responseData.data else { return }
            
            do {
                let channelsList = try JSONDecoder().decode(ChannelsList.self, from: data)
               
                if completion != nil { completion!(channelsList) }
            } catch {
                print("Couldn't decode data for ChannelsList: \(error)")
            }
        }
    }
    
    
    
    /// Request list of programms for a particular channel.
    /// - Parameters:
    ///   - cid: Channel identifier
    ///   - date: Date in format ddmmyy
    ///   - completion: completion handler
    func requestPrograms(forChannel cid: String, date: String, completion: ((ProgramsList) -> Void)? = nil) {
        let endPoint = "/api/json/epg"
        let interceptor = NetworkInterceptor()
        AF.request(baseUrl + endPoint, method: .get, parameters: ["cid": cid, "day": date], interceptor: interceptor).response { response in
            guard let data = response.data else { return }
            
            do {
                let programms = try JSONDecoder().decode(ProgramsList.self, from: data)
                if completion != nil { completion!(programms) }
            } catch {
                print("Couldn't decode data for ChannelsList: \(error)")
            }
        }
    }
    
    /// This function requests a URLProvider object from the API, then passes the object's urlString in the completion handler. By default it returns a url for the currently broadcasted program, but you can optionally pass the following parameters: ut_start and stream_protocol to get a url for some particular program.
    /// - Parameters:
    ///   - id: Channel id.
    ///   - ut_start: Start time of a program. Optioanl parameter.
    ///   - stream_protocol: Optioanl parameter.
    ///   - completion: completion handler.
    func requestURL(forChannel id: String, withStartTime ut_start: String? = nil, andProtocol stream_protocol: String? = nil, completion: ((String) -> Void)?) {
        let endPoint = "/api/json/get_url"
        let interceptor = NetworkInterceptor()
        
        if let gmt = ut_start, let stream_protocol = stream_protocol {
            AF.request(baseUrl + endPoint, method: .get, parameters: ["cid": id, "gmt": gmt, "stream_protocol": stream_protocol, "http_status_codes": "default"]).response { response in
                guard let data = response.data else { return }
                
                do {
                    let string = try JSONDecoder().decode(URLProvider.self, from: data).url
                    if let urlString = string, completion != nil {
                        completion!(urlString)
                    }
                } catch {
                    print("Couldn't decode data for URLProvider: \(error)")
                }
            }
        } else {
            AF.request(baseUrl + endPoint, method: .get, parameters: ["cid": id], interceptor: interceptor).response { response in
                guard let data = response.data else { return }
                
                do {
                    let string = try JSONDecoder().decode(URLProvider.self, from: data).url
                    if let urlString = string, completion != nil {
                        completion!(urlString)
                    }
                } catch {
                    print("Couldn't decode data for URLProvider: \(error)")
                }
            }
        }
    }
    
    
    func requestVideoURL(forVideo id: String, formetName: String, withStartTime ut_start: String? = nil, andProtocol stream_protocol: String? = nil, completion: ((String) -> Void)?) {
        let endPoint = "/api/json/vod_geturl"
        let interceptor = NetworkInterceptor()
        
        if  let stream_protocol = stream_protocol {
            
            AF.request(baseUrl + endPoint, method: .get, parameters: ["fileid": id,"formet":formetName, "stream_protocol": stream_protocol, "http_status_codes": "default"]).response { response in
                guard let data = response.data else { return }
                
                do {
                    let string = try JSONDecoder().decode(URLProvider.self, from: data).url
                    if let urlString = string, completion != nil {
                        completion!(urlString)
                    }
                } catch {
                    print("Couldn't decode data for URLProvider: \(error)")
                }
            }
        } else {
            
            AF.request(baseUrl + endPoint, method: .get, parameters: ["fileid": id,"formet":formetName], interceptor: interceptor).response { response in
                guard let data = response.data else { return }
                
                do {
                    let string = try JSONDecoder().decode(URLProvider.self, from: data).url
                    if let urlString = string, completion != nil {
                        completion!(urlString)
                    }
                } catch {
                    print("Couldn't decode data for URLProvider: \(error)")
                }
            }
        }
    }
    
    func requestSettings(timeshift: String?, timezone: String?, bitrate: String?, bitratehd: String?, vod_bitrate: String?,  withStartTime ut_start: String? = nil, andProtocol stream_protocol: String? = nil, completion: ((String) -> Void)?) {
        let endPoint = "/api/json/settings"
        let interceptor = NetworkInterceptor()
        
        if let gmt = ut_start, let stream_protocol = stream_protocol {
            
            AF.request(baseUrl + endPoint, method: .get, parameters: ["timeshift": timeshift, "timezone": timezone, "bitrate": bitrate, "bitratehd": bitratehd, "vod_bitrate": vod_bitrate]).response { response in
                guard let data = response.data else { return }
                
                do {
                    let string = try JSONDecoder().decode(URLProvider.self, from: data).url
                    if let urlString = string, completion != nil {
                        completion!(urlString)
                    }
                } catch {
                    print("Couldn't decode data for URLProvider: \(error)")
                }
            }
        } else {
            AF.request(baseUrl + endPoint, method: .get, parameters: ["timeshift": timeshift, "timezone": timezone, "bitrate": bitrate, "bitratehd": bitratehd, "vod_bitrate": vod_bitrate], interceptor: interceptor).response { response in
                guard let data = response.data else { return }
                
                do {
                    let string = try JSONDecoder().decode(URLProvider.self, from: data).url
                    if let urlString = string, completion != nil {
                        completion!(urlString)
                    }
                } catch {
                    print("Couldn't decode data for URLProvider: \(error)")
                }
            }
        }
    }
    
}
