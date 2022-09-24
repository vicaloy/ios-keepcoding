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
    
    init(nameFilter: String, token: String) {
        self.token = token
        self.nameFilter = nameFilter
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
        
        let service: Service<[Hero]> = Service()
        service.execute(urlRequest: urlRequest, completion: completion)
    }
    
}
