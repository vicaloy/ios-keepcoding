//
//  URLSessionMock.swift
//  DragonBallTests
//
//  Created by Victoria Aloy on 24/9/22.
//

import Foundation

enum ServiceErrorMock: Error {
    case mock
}

class URLSessionMock: URLSession {
    
    override init() {}
    
    var data: Data?
    var response: URLResponse?
    var error: Error?
    
    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return URLSessionDataTaskMock {
            completionHandler(self.data, self.response, self.error)
        }
    }
    
}

class URLSessionDataTaskMock: URLSessionDataTask {
    
    private let closure: () -> Void
    
    init(closure: @escaping () -> Void) {
        self.closure = closure
    }
    
    override func resume() {
        closure()
    }
}

