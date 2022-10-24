//
//  CreatorApi.swift
//  Marvel
//
//  Created by Victoria Aloy on 24/10/22.
//

import Foundation

struct CreatorApi: Codable, Hashable {
    static func == (lhs: CreatorApi, rhs: CreatorApi) -> Bool {
        lhs.available == rhs.available &&
        lhs.collectionURI == rhs.collectionURI &&
        lhs.items == rhs.items &&
        lhs.returned == rhs.returned
    }
    let available: Int?
    let collectionURI: String?
    let items: [CreatorItemApi]?
    let returned: Int?
}

// MARK: - CreatorsItem
struct CreatorItemApi: Codable, Hashable {
    let resourceURI: String?
    let name, role: String?
}
