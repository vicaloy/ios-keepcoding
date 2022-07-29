//
//  Hero.swift
//  DragonBall
//
//  Created by Victoria Aloy on 17/7/22.
//

import Foundation

import UIKit

struct Hero: Decodable {
    let id: String
    let name: String
    let description: String
    let photo: URL
    let favorite: Bool
}
