//
//  Service.swift
//  DragonBall
//
//  Created by Victoria Aloy on 17/9/22.
//

import Foundation

enum ServiceError: Error {
    case malformedURL
    case emptyResponse
    case requestParams
    case statusCode(code: Int?)
    case decodingFailed
    case unknown
}

class Service<T:Decodable> {
    
    func execute(urlRequest: URLRequest, completion: @escaping ((T?, Error?) -> Void)){
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard error == nil else {
                completion(nil, ServiceError.unknown)
                return
            }
            
            guard let data = data else {
                completion(nil, ServiceError.emptyResponse)
                return
            }
            
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                completion(nil, ServiceError.statusCode(code: (response as? HTTPURLResponse)?.statusCode))
                return
            }
            
            var responses: [T?] = []
            responses.append(String(data: data, encoding: .utf8) as? T)
            responses.append(self.genericResponse(data: data))
            
            if let r = responses.first(where: { $0 != nil}){
                completion(r as T?, nil)
            }else{
                completion(nil, ServiceError.decodingFailed)
            }
            
        }
        
        task.resume()
    }
    
    private func genericResponse(data: Data)->T?{
        guard let response = try? JSONDecoder().decode(T.self, from: data) else {
            return nil
        }
        return response
    }
    
}

