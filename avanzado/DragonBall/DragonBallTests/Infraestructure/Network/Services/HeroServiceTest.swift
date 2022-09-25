//
//  HeroServiceTest.swift
//  DragonBallTests
//
//  Created by Victoria Aloy on 25/9/22.
//

import Foundation
import XCTest
@testable import DragonBall

class HeroServiceTest: XCTestCase {
    
    private var urlSessionMock: URLSessionMock!
    private var heroService: HeroService!
    private var service: Service<[Hero]>!
    private let tokenTest = "TokenTest"
    
    override func setUpWithError() throws {
        urlSessionMock = URLSessionMock()
        service = Service(session: urlSessionMock!)
        heroService = HeroService(nameFilter: "", token: tokenTest, service: service!)
        
    }
    
    override func tearDownWithError() throws {
        urlSessionMock = nil
        service = nil
        heroService = nil
    }
    
    func testHeroService() {
        var retrievedHeros: [Hero]?
        
        //Given
        urlSessionMock.data = MockUtils.getDataFromJson(test: HeroServiceTest.self, resourceName: "heros")
        urlSessionMock.response = HTTPURLResponse(url: URL(string: "http")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        //When
        heroService.execute { heros, error in
            retrievedHeros = heros
        }
        
        //Then
        XCTAssertEqual(retrievedHeros?.first?.id, "Hero ID")
    }
    
    func testHeroServiceEmpty() {
        var retrievedHeros: [Hero]?
        
        //Given
        urlSessionMock.data = MockUtils.getDataFromJson(test: HeroServiceTest.self, resourceName: "empty")
        urlSessionMock.response = HTTPURLResponse(url: URL(string: "http")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        //When
        heroService.execute { heros, error in
            retrievedHeros = heros
        }
        
        //Then
        XCTAssertEqual(retrievedHeros?.count, 0)
    }

}

