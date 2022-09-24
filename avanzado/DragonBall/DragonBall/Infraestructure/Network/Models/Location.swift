//
//  LocationApi.swift
//  DragonBall
//
//  Created by Victoria Aloy on 21/9/22.
//

import Foundation

struct Location: Decodable, Equatable {
    var longitud: String?
    var latitud: String?
    var dateShow: String?
    var id: String
    var hero: Hero?
    
    static func == (a: Location, b: Location) -> Bool {
        return (a.id == b.id && a.longitud==b.longitud && a.latitud == b.latitud
                && a.dateShow == b.dateShow && a.hero == b.hero)
        }
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
