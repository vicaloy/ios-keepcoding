//
//  CharacterApi.swift
//  marvel
//
//  Created by Victoria Aloy on 19/10/22.
//
import Foundation

struct CharacterResponse: Codable {
    let code: Int?
    let status: String?
    let copyright: String?
    let attributionText: String?
    let attributionHTML: String?
    let etag: String?
    var data: DataResponse?
}

struct DataResponse: Codable {
    let offset, limit, total, count: Int?
    var results: [Character]?
}

struct Character: Codable, Hashable {
    static func == (lhs: Character, rhs: Character) -> Bool {
        lhs.id == rhs.id &&
        lhs.name == rhs.name &&
        lhs.description == rhs.description &&
        lhs.modified == rhs.modified &&
        lhs.thumbnail == rhs.thumbnail &&
        lhs.resourceURI == rhs.resourceURI &&
        lhs.comics == rhs.comics &&
        lhs.series == rhs.series &&
        lhs.events == rhs.events &&
        lhs.stories == rhs.stories &&
        lhs.urls == rhs.urls
    }
    
    let id: Int?
    let name, description: String?
    let modified: Date?
    let thumbnail: Thumbnail?
    let resourceURI: String?
    let comics, series: Comics?
    let stories: Stories?
    let events: Comics?
    let urls: [URLElement]?

    enum CodingKeys: String, CodingKey {
        case id, name
        case description
        case modified, thumbnail, resourceURI, comics, series, stories, events, urls
    }
}

struct Comics: Codable, Hashable {
    static func == (lhs: Comics, rhs: Comics) -> Bool {
        lhs.available == rhs.available &&
        lhs.collectionURI == rhs.collectionURI &&
        lhs.items == rhs.items &&
        lhs.returned == rhs.returned
    }
    
    let available: Int?
    let collectionURI: String?
    let items: [ComicsItem]?
    let returned: Int?
}

struct ComicsItem: Codable, Hashable {
    let resourceURI: String?
    let name: String?
}

struct Stories: Codable, Hashable {
    static func == (lhs: Stories, rhs: Stories) -> Bool {
        lhs.available == rhs.available &&
        lhs.collectionURI == rhs.collectionURI &&
        lhs.items == rhs.items &&
        lhs.returned == rhs.returned
    }
    
    let available: Int?
    let collectionURI: String?
    let items: [StoriesItem]?
    let returned: Int?
}

struct StoriesItem: Codable, Hashable {
    let resourceURI: String?
    let name: String?
    let type: String?
}

struct Thumbnail: Codable, Hashable {
    let path: String?
    let thumbnailExtension: String?

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

struct URLElement: Codable, Hashable {
    let type: URLType?
    let url: String?
}

enum URLType: String, Codable {
    case comiclink = "comiclink"
    case detail = "detail"
    case wiki = "wiki"
}

