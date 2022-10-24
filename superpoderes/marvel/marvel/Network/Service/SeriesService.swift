//
//  SerieService.swift
//  marvel
//
//  Created by Victoria Aloy on 23/10/22.
//

import Foundation
import Combine

class SeriesService{
    var service: BaseService<SerieResponse>
    
    init(service: BaseService<SerieResponse> = BaseService()) {
        self.service = service
    }
    
    func execute(serieId: String? = nil, page: Int = 0,
                 limit: Int = 20) -> AnyPublisher<SerieResponse, APIError> {
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
