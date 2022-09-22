//
//  LocationApi.swift
//  DragonBall
//
//  Created by Victoria Aloy on 21/9/22.
//

import Foundation

struct Location: Decodable {
    var longitud: String?
    var latitud: String?
    var dateShow: String?
    var id: String
    var hero: Hero?
}

extension Location {
    init(id: String){
        self.id = id
        self.longitud = nil
        self.latitud = nil
        self.dateShow = nil
        self.hero = nil
    }
}
