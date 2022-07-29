//
//  Character.swift
//  DragonBallApp
//
//  Created by Victoria Aloy on 28/7/22.
//

import Foundation


typealias DBCharacters = [DBCharacter]

protocol DBCharacter {
    var id: String { get set }
    var name: String { get set }
    var description: String { get set }
    var photo: URL { get set }
}
