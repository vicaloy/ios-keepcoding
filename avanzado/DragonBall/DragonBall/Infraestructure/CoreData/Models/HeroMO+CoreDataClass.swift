//
//  HeroMO+CoreDataClass.swift
//  DragonBall
//
//  Created by Victoria Aloy on 24/9/22.
//
//

import Foundation
import CoreData


public class HeroMO: NSManagedObject {}

extension HeroMO: ManagedObjectProtocol {
    func toEntity() -> Hero? {
        return Hero(id: id ?? "", name: name, description: descrip, photo: toUrl(str: photo), favorite: favorite)
    }
}

extension Hero: ManagedObjectConvertible {
    
    func toExistingManagedObject(in context: NSManagedObjectContext) -> HeroMO? {
        return HeroMO.single(with: id, from: context)
    }
    
    func toManagedObject(in context: NSManagedObjectContext) -> HeroMO? {
        let hero = HeroMO.getOrCreateSingle(with: id, from: context)
        hero.name = name
        hero.favorite = favorite ?? false
        hero.descrip = description
        hero.photo = photo?.absoluteString
        return hero
    }
}
