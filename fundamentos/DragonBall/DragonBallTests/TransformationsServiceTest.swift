//
//  TransformationsServiceTest.swift
//  DragonBallTests
//
//  Created by Victoria Aloy on 24/7/22.
//


import XCTest
@testable import DragonBall

class TransformationsServiceTest: XCTestCase {
    
    private var urlSessionMock: URLSessionMock!
    private var sut: TransformationsService!
    
    override func setUpWithError() throws {
        UserDefaultsData.saveToken(token: "token")
        urlSessionMock = URLSessionMock()
        sut = TransformationsService(urlSession: urlSessionMock)
    }
    
    override func tearDownWithError() throws {
        UserDefaultsData.deleteToken()
        sut = nil
    }
    
    func testGetTransformationsSuccess() {
        var error: NetworkError?
        var transformations: [Transformation]?
        let bundle = Bundle(for: TransformationsServiceTest.self)
        let id = "616ADA79-EF94-41BE-B4ED-3A44A3F3E2B7"
        
        //Given
        urlSessionMock.data = getJsonData(bundle:bundle, resourceName: "transformations")
        urlSessionMock.response = HTTPURLResponse(url: URL(string: "http")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        //When
        sut.getTransformations(id: id) { data, networkError in
            error = networkError
            transformations = data
        }
        
        //Then
        XCTAssertEqual(transformations?.first?.id, id)
        XCTAssertNil(error)
    }
    
    func testGetTransformationsSuccessWithEmptyTransformations() {
        var error: NetworkError?
        var transformations: [Transformation]?
        let bundle = Bundle(for: TransformationsServiceTest.self)
        
        //Given
        urlSessionMock.data = getJsonData(bundle:bundle, resourceName: "emptyTransformations")
        urlSessionMock.response = HTTPURLResponse(url: URL(string: "http")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        //When
        sut.getTransformations(id: "1"){ data, networkError in
            error = networkError
            transformations = data
        }
        
        //Then
        XCTAssertNotNil(transformations)
        XCTAssertEqual(transformations?.count, 0)
        XCTAssertNil(error)
    }
}
