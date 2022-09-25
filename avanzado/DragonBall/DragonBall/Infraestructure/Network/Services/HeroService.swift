//
//  HeroService.swift
//  DragonBall
//
//  Created by Victoria Aloy on 18/9/22.
//

import Foundation

class HeroService {
    private let nameFilter: String
    private let token: String
    private let service: Service<[Hero]>

    
    init(nameFilter: String, token: String, service: Service<[Hero]> = Service<[Hero]>()) {
        self.token = token
        self.nameFilter = nameFilter
        self.service = service
    }
    
    func execute(completion: @escaping(([Hero]?, Error?) ->Void)) {
        
        struct Body: Encodable {
            let name: String
        }
        
        let body = Body(name: nameFilter)
        
        let url = UrlRequest(url: Endpoints.herosAll, httpMethod: HttpMethod.post, body: body, token: token)
        let urlRequest = url.getUrlRequest()
        
        guard let urlRequest = urlRequest else {
            completion(nil, ServiceError.malformedURL)
            return
        }
        
        service.execute(urlRequest: urlRequest, completion: completion)
    }
    
}
