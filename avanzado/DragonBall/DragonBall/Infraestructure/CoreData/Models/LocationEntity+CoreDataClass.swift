//
//  LocationEntity+CoreDataClass.swift
//  DragonBall
//
//  Created by Victoria Aloy on 21/9/22.
//
//

import Foundation
import CoreData


public class LocationEntity: NSManagedObject {}

extension LocationEntity: ManagedObjectProtocol {
    func toEntity() -> Location? {
        return Location(longitud: longitud, latitud: latitud, dateShow: dateShow, id: id ?? "", hero: hero?.toEntity())
    }
}

extension Location: ManagedObjectConvertible {
    func toManagedObject(in context: NSManagedObjectContext) -> LocationEntity? {
        let location = LocationEntity.getOrCreateSingle(with: id, from: context)
        location.longitud = longitud
        location.latitud = latitud
        location.dateShow = dateShow
        location.hero = hero?.toManagedObject(in: context)
        
        return location
    }
}

