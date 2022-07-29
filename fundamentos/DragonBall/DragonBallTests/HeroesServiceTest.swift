//
//  HeroesServiceTest.swift
//  DragonBallTests
//
//  Created by Victoria Aloy on 24/7/22.
//

import XCTest
@testable import DragonBall

class HeroesServiceTest: XCTestCase {
    
    private var urlSessionMock: URLSessionMock!
    private var sut: HeroesService!
    
    override func setUpWithError() throws {
        UserDefaultsData.saveToken(token: "token")
        urlSessionMock = URLSessionMock()
        sut = HeroesService(urlSession: urlSessionMock)
    }
    
    override func tearDownWithError() throws {
        UserDefaultsData.deleteToken()
        sut = nil
    }
    
    func testGetHerosSuccess() {
        var error: NetworkError?
        var retrievedHeroes: [Hero]?
        let bundle = Bundle(for: HeroesServiceTest.self)
        
        //Given
        urlSessionMock.data = getJsonData(bundle:bundle, resourceName: "heroes")
        urlSessionMock.response = HTTPURLResponse(url: URL(string: "http")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        //When
        sut.getHeroes { heroes, networkError in
            error = networkError
            retrievedHeroes = heroes
        }
        
        //Then
        XCTAssertEqual(retrievedHeroes?.first?.id, "Hero ID")
        XCTAssertNil(error)
    }
    
    func testGetHerosSuccessWithEmptyHeroes() {
        var error: NetworkError?
        var retrievedHeroes: [Hero]?
        let bundle = Bundle(for: HeroesServiceTest.self)
        
        //Given
        urlSessionMock.data = getJsonData(bundle:bundle, resourceName: "emptyHeroes")
        urlSessionMock.response = HTTPURLResponse(url: URL(string: "http")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        //When
        sut.getHeroes { heroes, networkError in
            error = networkError
            retrievedHeroes = heroes
        }
        
        //Then
        XCTAssertNotNil(retrievedHeroes)
        XCTAssertEqual(retrievedHeroes?.count, 0)
        XCTAssertNil(error)
    }
}


