//
//  LocationServiceTest.swift
//  DragonBallTests
//
//  Created by Victoria Aloy on 25/9/22.
//

import Foundation
import XCTest
@testable import DragonBall

class LocationServiceTest: XCTestCase {
    
    private var urlSessionMock: URLSessionMock!
    private var locationService: LocationService!
    private var service: Service<[Location]>!
    private let tokenTest = "TokenTest"
    private let heroId = "Hero Id"
    
    override func setUpWithError() throws {
        urlSessionMock = URLSessionMock()
        service = Service(session: urlSessionMock!)
        locationService = LocationService(heroId: heroId, token: tokenTest, service: service)
        
    }
    
    override func tearDownWithError() throws {
        urlSessionMock = nil
        service = nil
        locationService = nil
    }
    
    func testLocationService() {
        var retrievedLocations: [Location]?
        
        //Given
        urlSessionMock.data = MockUtils.getDataFromJson(test: LocationServiceTest.self, resourceName: "locations")
        urlSessionMock.response = HTTPURLResponse(url: URL(string: "http")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        //When
        locationService.execute { locations, error in
            retrievedLocations = locations
        }
        
        //Then
        XCTAssertEqual(retrievedLocations?.first?.id, "Location ID")
    }
    
    func testLocationServiceEmpty() {
        var retrievedLocations: [Location]?
        
        //Given
        urlSessionMock.data = MockUtils.getDataFromJson(test: LocationServiceTest.self, resourceName: "empty")
        urlSessionMock.response = HTTPURLResponse(url: URL(string: "http")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        //When
        locationService.execute { locations, error in
            retrievedLocations = locations
        }
        
        //Then
        XCTAssertEqual(retrievedLocations?.count, 0)
    }

}

