//
//  Entities.swift
//  DragonBall
//
//  Created by Victoria Aloy on 18/9/22.
//

import Foundation
import CoreData
import UIKit

func heroEntityFromApi(context: NSManagedObjectContext, heroApi: HeroApi)->HeroEntity{
    let hero = HeroEntity(context: context)
    hero.photo = heroApi.photo.absoluteString
    hero.id = heroApi.id
    hero.favorite = heroApi.favorite
    hero.name = heroApi.name
    
    return hero
}

func locationEntityFromApi(context: NSManagedObjectContext, locationApi: LocationApi)->LocationEntity{
    let location = LocationEntity(context: context)
    location.hero = heroEntityFromApi(context: context, heroApi: locationApi.hero)
    location.dateShow = locationApi.dateShow
    location.id = locationApi.id
    location.latitud = locationApi.latitud
    location.longitud = locationApi.longitud
    
    return location
}
