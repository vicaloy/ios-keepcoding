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
        
        guard let url = URL(string: allHerosGet) else {
            completion(nil, ServiceError.malformedURL)
            return }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        struct Body: Encodable {
            let name: String
        }
        
        let body = Body(name: nameFilter)
        
        urlRequest.httpBody = try? JSONEncoder().encode(body)
        
        let service: Service<[Hero]> = Service()
        service.execute(urlRequest: urlRequest, completion: completion)
    }
    
}
