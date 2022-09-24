//
//  UrlRequest.swift
//  DragonBall
//
//  Created by Victoria Aloy on 24/9/22.
//

import Foundation

class UrlRequest<Body: Encodable>{
    let url: String
    let token: String
    let httpMethod: HttpMethod
    let body: Body
    
    init(url: String, httpMethod: HttpMethod, body: Body, token: String){
        self.url = url
        self.token = token
        self.httpMethod = httpMethod
        self.body = body
    }
    
    func getUrlRequest()->URLRequest?{
        guard let url = URL(string: url) else {
            return nil
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = try? JSONEncoder().encode(body)
        
        return urlRequest
    }
    
}
