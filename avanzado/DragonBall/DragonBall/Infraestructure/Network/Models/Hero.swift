//
//  Hero.swift
//  DragonBall
//
//  Created by Victoria Aloy on 24/9/22.
//

import Foundation

struct Hero: Decodable, Equatable {
    var id: String
    var name: String?
    var description: String?
    var photo: URL?
    var favorite: Bool?
    
    static func == (a: Hero, b: Hero) -> Bool {
        return (a.id == b.id && a.name==b.name && a.favorite == b.favorite
                && a.description == b.description && a.photo == b.photo)
        }
}

extension Hero {
    init(id: String){
        self.id = id
        self.name = nil
        self.description = nil
        self.photo = nil
        self.favorite = false
    }
}
