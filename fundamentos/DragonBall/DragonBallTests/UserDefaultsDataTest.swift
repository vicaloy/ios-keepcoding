//
//  UserDefaultsDataTest.swift
//  DragonBallTests
//
//  Created by Victoria Aloy on 23/7/22.
//

import XCTest
@testable import DragonBall

class UserDefaultsDataTest: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        UserDefaultsData.deleteToken()
    }
    
    func testSaveToken() throws {
        //Given
        let saveToken = "token"
        //When
        UserDefaultsData.saveToken(token: saveToken)
        //Then
        let getToken = UserDefaultsData.getToken()
        XCTAssertEqual(saveToken, getToken)
    }
    
    func testGetNonExistentToken() throws {
        //Then
        let token = UserDefaultsData.getToken()
        XCTAssertNil(token)
    }
    
    func testDeleteToken() throws {
        //Given
        let saveToken = "token"
        UserDefaultsData.saveToken(token: saveToken)
        //When
        UserDefaultsData.deleteToken()
        //Then
        let getToken = UserDefaultsData.getToken()
        XCTAssertNil(getToken)
    }
    
}
