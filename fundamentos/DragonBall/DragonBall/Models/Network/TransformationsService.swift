//
//  TransformationsService.swift
//  DragonBall
//
//  Created by Victoria Aloy on 18/7/22.
//

import Foundation

final class TransformationsService{
    let session: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.session = urlSession
    }
    
    func getTransformations(id: String, completion: @escaping ([Transformation], NetworkError?) -> Void) {
        guard let url = URL(string: "https://vapor2022.herokuapp.com/api/heros/tranformations") else {
            completion([], NetworkError.malformedURL)
            return
        }
        
        guard let token = UserDefaultsData.getToken() else {
            completion([], NetworkError.other)
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        struct Body: Encodable {
            let id: String
        }
        
        let body = Body(id: id)
        
        urlRequest.httpBody = try? JSONEncoder().encode(body)
        
        let task = session.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else {
                completion([], NetworkError.other)
                return
            }
            
            guard let data = data else {
                completion([], NetworkError.noData)
                return
            }
            
            guard let httpResponse = (response as? HTTPURLResponse),
                  httpResponse.statusCode == 200 else {
                completion([], NetworkError.errorCode((response as? HTTPURLResponse)?.statusCode))
                return
            }
            
            guard let transformationsResponse = try? JSONDecoder().decode([Transformation].self, from: data) else {
                completion([], NetworkError.decoding)
                return
            }
            
            completion(transformationsResponse, nil)
        }
        
        task.resume()
    }
    
}
