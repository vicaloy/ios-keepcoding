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
        guard let url = URL(string: heroLocationsGet) else {
            completion(nil, ServiceError.malformedURL)
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        struct Body: Encodable {
            let id: String
        }
        
        let body = Body(id: heroId)
        
        urlRequest.httpBody = try? JSONEncoder().encode(body)
        
        let service: Service<[Location]> = Service()
        service.execute(urlRequest: urlRequest, completion: completion)
    }
    
}
