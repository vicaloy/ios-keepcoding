//
//  LoginServiceTest.swift
//  DragonBallTests
//
//  Created by Victoria Aloy on 24/7/22.
//

import XCTest
@testable import DragonBall

enum ErrorMock: Error {
    case mockCase
}

class LoginServiceTests: XCTestCase {
    
    private var urlSessionMock: URLSessionMock!
    private var sut: LoginService!
    
    override func setUpWithError() throws {
        urlSessionMock = URLSessionMock()
        
        sut = LoginService(urlSession: urlSessionMock)
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testLoginFailWithNoData() {
        var error: NetworkError?
        
        //Given
        urlSessionMock.data = nil
        
        //When
        sut.login(user: "", password: "") { _, networkError in
            error = networkError
        }
        
        //Then
        XCTAssertEqual(error, .noData)
    }
    
    func testLoginFailWithError() {
        var error: NetworkError?
        
        //Given
        urlSessionMock.data = nil
        urlSessionMock.error = ErrorMock.mockCase
        
        //When
        sut.login(user: "", password: "") { _, networkError in
            error = networkError
        }
        
        //Then
        XCTAssertEqual(error, .other)
    }
    
    func testLoginFailWithErrorCodeNil() {
        var error: NetworkError?
        
        //Given
        urlSessionMock.data = "TokenString".data(using: .utf8)!
        urlSessionMock.response = nil
        
        //When
        sut.login(user: "", password: "") { _, networkError in
            error = networkError
        }
        
        //Then
        XCTAssertEqual(error, .errorCode(nil))
    }
    
    func testLoginFailWithErrorCode() {
        var error: NetworkError?
        
        //Given
        urlSessionMock.data = "TokenString".data(using: .utf8)!
        urlSessionMock.response = HTTPURLResponse(url: URL(string: "http")!, statusCode: 404, httpVersion: nil, headerFields: nil)
        
        //When
        sut.login(user: "", password: "") { _, networkError in
            error = networkError
        }
        
        //Then
        XCTAssertEqual(error, .errorCode(404))
    }
    
    func testLoginSuccessWithMockToken() {
        var error: NetworkError?
        var retrievedToken: String?
        let token = "token"
        
        //Given
        urlSessionMock.error = nil
        urlSessionMock.data = token.data(using: .utf8)!
        urlSessionMock.response = HTTPURLResponse(url: URL(string: "http")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        //When
        sut.login(user: "", password: "") { token, networkError in
            retrievedToken = token
            error = networkError
        }
        
        //Then
        XCTAssertEqual(retrievedToken, token)
        XCTAssertNil(error)
    }
    
}

