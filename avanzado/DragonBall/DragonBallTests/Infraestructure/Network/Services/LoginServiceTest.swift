//
//  LoginServiceTest.swift
//  DragonBallTests
//
//  Created by Victoria Aloy on 25/9/22.
//

import Foundation
import XCTest
@testable import DragonBall

class LoginServiceTest: XCTestCase {
    
    private var urlSessionMock: URLSessionMock!
    private var loginService: LoginService!
    private var service: Service<String>!
    private let user = "usuario"
    private let password = "password"
    private let tokenTest = "TokenTest"

    override func setUpWithError() throws {
        urlSessionMock = URLSessionMock()
        service = Service(session: urlSessionMock!)
        loginService = LoginService(user: user, password: password, service: service!)
        
    }
    
    override func tearDownWithError() throws {
        urlSessionMock = nil
        service = nil
        loginService = nil
    }

    
    func testLoginServiceEmptyResponse(){
        //Given
        var serviceError: ServiceError? = nil
        urlSessionMock.data = nil
        //When
        loginService.execute{ token, error in
            serviceError = error as? ServiceError
        }
        //Then
        XCTAssertEqual(serviceError, ServiceError.emptyResponse)
        
    }
    
    func testLoginServiceWithError() {
        //Given
        var serviceError: ServiceError? = nil
        urlSessionMock.data = nil
        urlSessionMock.error = ServiceErrorMock.mock
        //When
        loginService.execute{token, error in
            serviceError = error as? ServiceError
        }
        //Then
        XCTAssertEqual(serviceError, ServiceError.unknown)
        
    }
    
    func testLoginServiceErrorCodeNil() {
        //Given
        var serviceError: ServiceError? = nil
        urlSessionMock.data = tokenTest.data(using: .utf8)!
        urlSessionMock.response = nil
        //When
        loginService.execute{ token, error in
            serviceError = error as? ServiceError
        }
        //Then
        XCTAssertEqual(serviceError, ServiceError.statusCode(code: nil))
    }
    
    func testLoginServiceWithErrorCode() {
        //Given
        let statusCode = 404
        var serviceError: ServiceError? = nil
        urlSessionMock.data = tokenTest.data(using: .utf8)!
        urlSessionMock.response = HTTPURLResponse(url: URL(string: "http")!, statusCode: statusCode, httpVersion: nil, headerFields: nil)
        //When
        loginService.execute{ token, error in
            serviceError = error as? ServiceError
        }
        //Then
        XCTAssertEqual(serviceError, ServiceError.statusCode(code: statusCode))

    }
    
    func testLoginService() {
        //Given
        var retrivedToken: String?
        urlSessionMock.error = nil
        urlSessionMock.data = tokenTest.data(using: .utf8)!
        urlSessionMock.response = HTTPURLResponse(url: URL(string: "http")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        //When
        loginService.execute{ token, error in
            retrivedToken = token
        }
        //Then
        XCTAssertEqual(tokenTest, retrivedToken)
        
    }

}
