//
//  LocationMO+CoreDataClass.swift
//  DragonBall
//
//  Created by Victoria Aloy on 24/9/22.
//
//

import Foundation
import CoreData


public class LocationMO: NSManagedObject {}

extension LocationMO: ManagedObjectProtocol {
    func toEntity() -> Location? {
        return Location(longitud: longitud, latitud: latitud, dateShow: dateShow, id: id ?? "", hero: hero?.toEntity())
    }
}

extension Location: ManagedObjectConvertible {
    func deleteManagedObject(in context: NSManagedObjectContext) {
        LocationMO.delete(with: id, from: context)
    }
    
    func toExistingManagedObject(in context: NSManagedObjectContext) -> LocationMO? {
        return LocationMO.single(with: id, from: context)
    }
    
    func toManagedObject(in context: NSManagedObjectContext) -> LocationMO? {
        let location = LocationMO.getOrCreateSingle(with: id, from: context)
        location.longitud = longitud
        location.latitud = latitud
        location.dateShow = dateShow
        location.hero = hero?.toExistingManagedObject(in: context)
        
        return location
    }
}
