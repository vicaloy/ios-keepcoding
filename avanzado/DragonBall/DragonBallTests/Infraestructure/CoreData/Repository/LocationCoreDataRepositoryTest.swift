//
//  LocationCoreDataRepositoryTest.swift
//  DragonBallTests
//
//  Created by Victoria Aloy on 24/9/22.
//

import Foundation
import XCTest

@testable import DragonBall

class LocationCoreDataRepositoryTest: XCTestCase {
    
    let locationCoreDataRepository = LocationCoreDataRepository()
    
    override func setUpWithError() throws {
        clearData()
    }

    
    override func tearDownWithError() throws {
        clearData()
    }
    
    func testInsertEmptyLocations(){
        //Given
        let locations: [Location] = []
        //When
        locationCoreDataRepository.insert(locations: locations)
        //Then
        locationCoreDataRepository.fetch{ results in
            XCTAssertEqual(results, locations)
        }
    }
    
    func testInsertLocation(){
        //Given
        let location = givenOtherLocation()
        //When
        locationCoreDataRepository.insert(locations: [location])
        //Then
        locationCoreDataRepository.fetch{ heros in
            
            let result = heros?.first(where: { $0.id == location.id})
            XCTAssertEqual(result, location)
            
        }
    }
    
    func testInsertLocations(){
        //Given
        let locations = givenLocations()
        //When
        locationCoreDataRepository.insert(locations: locations)
        //Then
        locationCoreDataRepository.fetch{ results in
            XCTAssertEqual(results, locations)
        }
    }
    
    func testFindLocationsByHero(){
        //Given
        let otherLocation = givenOtherLocation()
        let locations = givenLocations()
        var locationsToSave: [Location] = [otherLocation]
        locationsToSave.append(contentsOf: locations)
        let predicate = NSPredicate(format: "hero.id == '\(String(describing: otherLocation.hero?.id))'")
        
        //When
        locationCoreDataRepository.insert(locations: locations)
        //Then
        locationCoreDataRepository.fetch(predicate: predicate){ results in
            XCTAssertEqual(results, [otherLocation])
        }
    }

}

extension LocationCoreDataRepositoryTest {
    
    func givenHero()-> Hero{
        return Hero(id: "1-test",
                    name: "Lorem",
                        description: "Lorem impsu",
                        photo: toUrl(str: "https://cdn.alfabetajuega.com/alfabetajuega/2020/12/goku1.jpg?width=300"), favorite: true)
    }
    
    func givenOtherHero()-> Hero{
        return Hero(id: "2-test",
                    name: "Lorem 2",
                        description: "Lorem impsu 2",
                        photo: toUrl(str: "https://cdn.alfabetajuega.com/alfabetajuega/2020/12/goku1.jpg?width=300"), favorite: true)
    }
    
    func givenOtherLocation() -> Location{
        return Location(longitud: "0.0",
                        latitud: "0.0",
                        dateShow: "",
                        id: "1-test",
                        hero: givenOtherHero())
    }
    
    func givenLocations() -> [Location]{
        return [Location(longitud: "0.0",
                         latitud: "0.0",
                         dateShow: "",
                         id: "2-test",
                         hero: givenHero()),
                Location(longitud: "0.0",
                                latitud: "0.0",
                                dateShow: "",
                                id: "3-test",
                                hero: givenHero()),
                Location(longitud: "0.0",
                                latitud: "0.0",
                                dateShow: "",
                                id: "4-test",
                                hero: givenHero())]
    }
    
    func clearData(){
        var locations = givenLocations()
        locations.append(givenOtherLocation())
        locationCoreDataRepository.delete(locations: locations)
    }
}
