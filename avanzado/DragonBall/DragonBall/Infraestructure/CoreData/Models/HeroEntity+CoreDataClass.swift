//
//  HeroEntity+CoreDataClass.swift
//  DragonBall
//
//  Created by Victoria Aloy on 21/9/22.
//
//

import Foundation
import CoreData


public class HeroEntity: NSManagedObject {}

extension HeroEntity: ManagedObjectProtocol {
    func toEntity() -> Hero? {
        return Hero(id: id ?? "", name: name, description: descrip, photo: toUrl(str: photo), favorite: favorite)
    }
}

extension Hero: ManagedObjectConvertible {
    func toExistingManagedObject(in context: NSManagedObjectContext) -> HeroEntity? {
        return HeroEntity.getOrCreateSingle(with: id, from: context)
    }
    
    func toManagedObject(in context: NSManagedObjectContext) -> HeroEntity? {
        let hero = HeroEntity.getOrCreateSingle(with: id, from: context)
        hero.name = name
        hero.favorite = favorite ?? false
        hero.descrip = description
        hero.photo = photo?.absoluteString
        return hero
    }
}
