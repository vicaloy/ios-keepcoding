//
//  ServiceMock.swift
//  DragonBallTests
//
//  Created by Victoria Aloy on 24/9/22.
//

import Foundation
@testable import DragonBall

class ServiceMock<T:Decodable>: Service<T>{
    let data: T?
    let error: Error?
    
    init(data: T?, error: Error?){
        self.data = data
        self.error = error
    }
    
    override func execute(urlRequest: URLRequest, completion: @escaping ((T?, Error?) -> Void)) {
        completion(data, error)
    }
    
}
