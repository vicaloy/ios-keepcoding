

import Foundation
import Combine

class SeriesService: SeriesServiceProtocol{
    
    let service = BaseService<ResponseApi<SerieApi>>()
    
    func execute(serieId: String? = nil, page: Int = 0,
                 limit: Int = 20) -> AnyPublisher<ResponseApi<SerieApi>, APIError> {
        var endPoint = Endpoints.series
        var pageParams = ""
        let pageNumber = (page < 0 ? 0 : page)
        let offset = limit * pageNumber
        if let _ = serieId {
            endPoint = endPoint + "/\(serieId!)"
        } else {
            pageParams = "&limit=\(limit)&offset=\(offset)"
        }
        
        let urlString = "\(endPoint)?apikey=\(Secret.publicKey)&hash=\(Secret.md5)&ts=\(Secret.ts)\(pageParams)"
        
        if let url = URL(string: urlString){
            
            return service.buildRequest(url: url, httpMethod: HttpMethod.get)
        }
        
        return Fail(error:APIError.urlError).eraseToAnyPublisher()
    }
}
