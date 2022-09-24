//
//  HeroCoreDataRepositoryTest.swift
//  DragonBallTests
//
//  Created by Victoria Aloy on 24/9/22.
//

import Foundation
import XCTest

@testable import DragonBall

class HeroCoreDataRepositoryTest: XCTestCase {
    
    let heroCoreDataRepository = HeroCoreDataRepository()
    
    override func setUpWithError() throws {
        clearData()
    }

    
    override func tearDownWithError() throws {
        clearData()
    }
    
    func testInsertEmptyHeros(){
        //Given
        let heros: [Hero] = []
        //When
        heroCoreDataRepository.insert(heros: heros)
        //Then
        heroCoreDataRepository.fetch{ results in
            XCTAssertEqual(results, heros)
        }
    }
    
    func testInsertHero(){
        //Given
        let hero = givenHero()
        //When
        heroCoreDataRepository.insert(heros: [hero])
        //Then
        heroCoreDataRepository.fetch{ heros in
            
            let result = heros?.first(where: { $0.id == hero.id})
            XCTAssertEqual(result, hero)
            
        }
    }
    
    func testInsertHeros(){
        //Given
        let heros = givenHeros()
        //When
        heroCoreDataRepository.insert(heros: heros)
        //Then
        heroCoreDataRepository.fetch{ results in
            XCTAssertEqual(results, heros)
            
        }
    }

}

extension HeroCoreDataRepositoryTest {
    
    func givenHero()-> Hero{
        return Hero(id: "1-test",
                    name: "Lorem",
                        description: "Lorem impsu",
                        photo: toUrl(str: "https://cdn.alfabetajuega.com/alfabetajuega/2020/12/goku1.jpg?width=300"), favorite: true)
    }
    
    func givenHeros()->[Hero]{
        return [
            Hero(id: "2-test",
                        name: "Lorem 2",
                            description: "Lorem impsu 2",
                            photo: toUrl(str: "https://cdn.alfabetajuega.com/alfabetajuega/2020/12/goku1.jpg?width=300"), favorite: true),
            Hero(id: "3-test",
                        name: "Lorem 3",
                            description: "Lorem impsu 3",
                            photo: toUrl(str: "https://cdn.alfabetajuega.com/alfabetajuega/2020/12/goku1.jpg?width=300"), favorite: true),
            Hero(id: "4-test",
                        name: "Lorem 4",
                            description: "Lorem impsu 4",
                            photo: toUrl(str: "https://cdn.alfabetajuega.com/alfabetajuega/2020/12/goku1.jpg?width=300"), favorite: true)
        ]
    }
    
    func clearData(){
        var heros = givenHeros()
        heros.append(givenHero())
        heroCoreDataRepository.delete(heros: heros)
    }
}
