//
//  LoginService.swift
//  DragonBall
//
//  Created by Victoria Aloy on 17/7/22.
//

import Foundation

final class LoginService {
    
    let session: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.session = urlSession
    }
    
    func login(user: String, password: String, completion: @escaping (String?, NetworkError?) -> Void) {
        guard let url = URL(string: "https://vapor2022.herokuapp.com/api/auth/login") else {
            completion(nil, NetworkError.malformedURL)
            return
        }
        
        let loginString = String(format: "%@:%@", user, password)
        guard let loginData = loginString.data(using: .utf8) else {
            completion(nil, NetworkError.dataFormatting)
            return
        }
        let base64LoginString = loginData.base64EncodedString()
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        
        let task = session.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else {
                completion(nil, NetworkError.other)
                return
            }
            
            guard let data = data else {
                completion(nil, NetworkError.noData)
                return
            }
            
            guard let httpResponse = (response as? HTTPURLResponse),
                  httpResponse.statusCode == 200 else {
                completion(nil, NetworkError.errorCode((response as? HTTPURLResponse)?.statusCode))
                return
            }
            
            guard let token = String(data: data, encoding: .utf8) else {
                completion(nil, NetworkError.tokenFormatError)
                return
            }
            
            completion(token, nil)
        }
        
        task.resume()
    }
}
