//
//  HeroApi.swift
//  DragonBall
//
//  Created by Victoria Aloy on 20/9/22.
//

import Foundation

import Foundation

struct Hero: Decodable {
    var id: String
    var name: String?
    var description: String?
    var photo: URL?
    var favorite: Bool?
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
