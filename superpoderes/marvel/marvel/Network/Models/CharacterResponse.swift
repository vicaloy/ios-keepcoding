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
    var data: CharacterData?
}

struct CharacterData: Codable {
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
    let thumbnail: CharacterThumbnail?
    let resourceURI: String?
    let comics, series: CharacterComics?
    let stories: CharacterStories?
    let events: CharacterComics?
    let urls: [CharacterURLElement]?

    enum CodingKeys: String, CodingKey {
        case id, name
        case description
        case modified, thumbnail, resourceURI, comics, series, stories, events, urls
    }
}

struct CharacterComics: Codable, Hashable {
    static func == (lhs: CharacterComics, rhs: CharacterComics) -> Bool {
        lhs.available == rhs.available &&
        lhs.collectionURI == rhs.collectionURI &&
        lhs.items == rhs.items &&
        lhs.returned == rhs.returned
    }
    
    let available: Int?
    let collectionURI: String?
    let items: [CharacterComicsItem]?
    let returned: Int?
}

struct CharacterComicsItem: Codable, Hashable {
    let resourceURI: String?
    let name: String?
}

struct CharacterStories: Codable, Hashable {
    static func == (lhs: CharacterStories, rhs: CharacterStories) -> Bool {
        lhs.available == rhs.available &&
        lhs.collectionURI == rhs.collectionURI &&
        lhs.items == rhs.items &&
        lhs.returned == rhs.returned
    }
    
    let available: Int?
    let collectionURI: String?
    let items: [CharacterStoriesItem]?
    let returned: Int?
}

struct CharacterStoriesItem: Codable, Hashable {
    let resourceURI: String?
    let name: String?
    let type: String?
}

struct CharacterThumbnail: Codable, Hashable {
    let path: String?
    let thumbnailExtension: String?

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

struct CharacterURLElement: Codable, Hashable {
    let type: CharacterURLType?
    let url: String?
}

enum CharacterURLType: String, Codable {
    case comiclink = "comiclink"
    case detail = "detail"
    case wiki = "wiki"
}

