//
//  ComicApi.swift
//  Marvel
//
//  Created by Victoria Aloy on 24/10/22.
//

import Foundation

struct ComicApi: Codable, Hashable {
    static func == (lhs: ComicApi, rhs: ComicApi) -> Bool {
        lhs.available == rhs.available &&
        lhs.collectionURI == rhs.collectionURI &&
        lhs.items == rhs.items &&
        lhs.returned == rhs.returned
    }
    
    let available: Int?
    let collectionURI: String?
    let items: [ComicItemApi]?
    let returned: Int?
}

struct ComicItemApi: Codable, Hashable {
    let resourceURI: String?
    let name: String?
}
