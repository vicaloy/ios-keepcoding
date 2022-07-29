//
//  HeroesService.swift
//  DragonBall
//
//  Created by Victoria Aloy on 17/7/22.
//

import Foundation

final class HeroesService{
    let session: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.session = urlSession
    }
    
    func getHeroes(name: String = "", completion: @escaping ([Hero], NetworkError?) -> Void) {
        guard let url = URL(string: "https://vapor2022.herokuapp.com/api/heros/all") else {
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
            let name: String
        }
        
        let body = Body(name: name)
        
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
            
            guard let heroesResponse = try? JSONDecoder().decode([Hero].self, from: data) else {
                completion([], NetworkError.decoding)
                return
            }
            
            completion(heroesResponse, nil)
        }
        
        task.resume()
    }
    
}
