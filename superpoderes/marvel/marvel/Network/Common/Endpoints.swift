//
//  Endpoints.swift
//  marvel
//
//  Created by Victoria Aloy on 21/10/22.
//

import Foundation

private let base = "https://gateway.marvel.com/"

enum Endpoints{
    static let characters = "\(base)v1/public/characters"
    static let series = "\(base)v1/public/series"
}
