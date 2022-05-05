import Foundation
import Alamofire

class VideoDetailsServiceImpl: VideoDetailsService {
    
    func getVideoDetails(withID id: String, _ completion: @escaping (VideoDetailResponse?, BaseServiceError?) -> Void) -> Request? {
        
        let parameters: Parameters = [
            "id": id,
        ]
        
        let webClient = WebClient<VideoDetailResponse>()
        
        return webClient.request(path: "/api/json/vod_info", method: .get, parameters: parameters, completion: completion)
    }
    
    func getVideoFile(withID id: String,format: String, stream_protocol: String, _ completion: @escaping (VideoFileResponse?, BaseServiceError?) -> Void) -> Request? {
        
        let parameters: Parameters = [
            "fileid": id,
            "format": format,
            "download": stream_protocol
        ]
        
        let webClient = WebClient<VideoFileResponse>()
        return webClient.request(path: "/api/json/vod_geturl", method: .get, parameters: parameters, completion: completion)
    }
    
}
