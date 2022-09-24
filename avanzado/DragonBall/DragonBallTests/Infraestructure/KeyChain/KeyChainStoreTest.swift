//
//  KeyChainStoreTest.swift
//  DragonBallTests
//
//  Created by Victoria Aloy on 24/9/22.
//

import XCTest
@testable import DragonBall


class KeyChainStoreTest: XCTestCase {
    let keyChainStore = KeyChainStore()

    override func tearDownWithError() throws {
        keyChainStore.delete(service: getService(), account: getAccount())
    }

    func testSave() throws {
        //Given
        guard let data = getData() else {
            return XCTFail()
        }
        
        //When
        keyChainStore.save(data: data, service: getService(), account: getAccount())
        
        //Then
        let result = keyChainStore.read(service: getService(), account: getAccount())
        let decoded = String(decoding: result ?? Data(), as: UTF8.self)
        XCTAssertEqual(getStringData(), decoded)
        
    }
    
    func testDelete() throws {
        //Given
        guard let data = getData() else {
            return XCTFail()
        }
        
        //When
        keyChainStore.save(data: data, service: getService(), account: getAccount())
        keyChainStore.delete(service: getService(), account: getAccount())
        
        //Then
        let result = keyChainStore.read(service: getService(), account: getAccount())
        let decoded = String(decoding: result ?? Data(), as: UTF8.self)
        XCTAssertEqual(decoded, "")
    }

}

extension KeyChainStoreTest {
    
    func getService()->String{
        return "Service"
    }
    
    func getAccount()->String{
        return "Account"
    }
    
    func getStringData()->String{
        return "Data"
    }
    
    func getData()->Data?{
        getStringData().data(using: .utf8)
    }
}
