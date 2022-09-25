//
//  LoginService.swift
//  DragonBall
//
//  Created by Victoria Aloy on 17/9/22.
//

import Foundation

class LoginService {
    
    private let user: String
    private let password: String
    private let service: Service<String>
    
    init(user: String, password: String, service: Service<String> = Service<String>()) {
        self.user = user
        self.password = password
        self.service = service
    }
    
    func execute(completion: @escaping((String?, Error?) ->Void)) {
        
        guard let url = URL(string: Endpoints.login) else {
            completion(nil, ServiceError.malformedURL)
            return }
        
        guard let credentials = String(format: "%@:%@", user, password).data(using: .utf8) else {
            completion(nil, ServiceError.requestParams)
            return }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HttpMethod.post.rawValue
        urlRequest.setValue("Basic \(credentials.base64EncodedString())", forHTTPHeaderField: "Authorization")
        
        service.execute(urlRequest: urlRequest, completion: completion)
    }
}
