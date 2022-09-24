//
//  LocationService.swift
//  DragonBall
//
//  Created by Victoria Aloy on 18/9/22.
//

import Foundation

class LocationService {
    private let heroId: String
    private let token: String
    
    init(heroId: String, token: String) {
        self.token = token
        self.heroId = heroId
    }
    
    func execute(completion: @escaping(([Location]?, Error?) ->Void)) {
        
        struct Body: Encodable {
            let id: String
        }
        
        let body = Body(id: heroId)
        
        let url = UrlRequest(url: Endpoints.heroLocatios, httpMethod: HttpMethod.post, body: body, token: token)
        let urlRequest = url.getUrlRequest()

        guard let urlRequest = urlRequest else {
            completion(nil, ServiceError.malformedURL)
            return
            
        }
        
        let service: Service<[Location]> = Service()
        service.execute(urlRequest: urlRequest, completion: completion)
    }
    
}
