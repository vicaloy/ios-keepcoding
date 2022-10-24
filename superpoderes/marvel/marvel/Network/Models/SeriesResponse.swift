//
//  SeriesResponse.swift
//  marvel
//
//  Created by Victoria Aloy on 23/10/22.
//

import Foundation

// MARK: - SerieResponse
struct SerieResponse: Codable {
    let code: Int?
    let status, copyright, attributionText, attributionHTML: String?
    let etag: String?
    let data: SerieData?
}

// MARK: - DataClass
struct SerieData: Codable {
    let offset, limit, total, count: Int?
    let results: [Serie]?
}

// MARK: - Result
struct Serie: Codable, Hashable, Identifiable {
    static func == (lhs: Serie, rhs: Serie) -> Bool {
        lhs.id == rhs.id &&
        lhs.title == rhs.title &&
        lhs.description == rhs.description &&
        lhs.resourceURI == rhs.resourceURI &&
        lhs.urls == rhs.urls &&
        lhs.startYear == rhs.startYear &&
        lhs.endYear == rhs.endYear &&
        lhs.rating == rhs.rating &&
        lhs.type == rhs.type &&
        lhs.modified == rhs.modified &&
        lhs.thumbnail == rhs.thumbnail &&
        lhs.creators == rhs.creators &&
        lhs.characters == rhs.characters &&
        lhs.stories == rhs.stories &&
        lhs.comics == rhs.comics &&
        lhs.events == rhs.events
    }
    
    let id: Int?
    let title, description: String?
    let resourceURI: String?
    let urls: [SerieURLElement]?
    let startYear, endYear: Int?
    let rating, type: String?
    let modified: Date?
    let thumbnail: SerieThumbnail?
    let creators: SerieCreators?
    let characters: SerieCharacters?
    let stories: SerieStories?
    let comics, events: SerieCharacters?

    enum CodingKeys: String, CodingKey {
        case id, title
        case description = "description"
        case resourceURI, urls, startYear, endYear, rating, type, modified, thumbnail, creators, characters, stories, comics, events
    }
}

// MARK: - Characters
struct SerieCharacters: Codable, Hashable {
    static func == (lhs: SerieCharacters, rhs: SerieCharacters) -> Bool {
        lhs.available == rhs.available &&
        lhs.collectionURI == rhs.collectionURI &&
        lhs.items == rhs.items &&
        lhs.returned == rhs.returned
    }
    
    let available: Int?
    let collectionURI: String?
    let items: [SerieCharactersItem]?
    let returned: Int?
}

// MARK: - CharactersItem
struct SerieCharactersItem: Codable, Hashable {
    let resourceURI: String?
    let name: String?
}

// MARK: - Creators
struct SerieCreators: Codable, Hashable {
    static func == (lhs: SerieCreators, rhs: SerieCreators) -> Bool {
        lhs.available == rhs.available &&
        lhs.collectionURI == rhs.collectionURI &&
        lhs.items == rhs.items &&
        lhs.returned == rhs.returned
    }
    let available: Int?
    let collectionURI: String?
    let items: [SerieCreatorsItem]?
    let returned: Int?
}

// MARK: - CreatorsItem
struct SerieCreatorsItem: Codable, Hashable {
    let resourceURI: String?
    let name, role: String?
}

// MARK: - Stories
struct SerieStories: Codable, Hashable {
    static func == (lhs: SerieStories, rhs: SerieStories) -> Bool {
        lhs.available == rhs.available &&
        lhs.collectionURI == rhs.collectionURI &&
        lhs.items == rhs.items &&
        lhs.returned == rhs.returned
    }
    
    let available: Int?
    let collectionURI: String?
    let items: [SerieStoriesItem]?
    let returned: Int?
}

// MARK: - StoriesItem
struct SerieStoriesItem: Codable, Hashable {
    static func == (lhs: SerieStoriesItem, rhs: SerieStoriesItem) -> Bool {
        lhs.resourceURI == rhs.resourceURI &&
        lhs.name == rhs.name &&
        lhs.type == rhs.type
    }
    
    let resourceURI: String?
    let name: String?
    let type: SerieTypeEnum?
}

enum SerieTypeEnum: String, Codable, Hashable {
    case cover = "cover"
    case interiorStory = "interiorStory"
}

// MARK: - Thumbnail
struct SerieThumbnail: Codable, Hashable {
    let path: String?
    let thumbnailExtension: String?

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

// MARK: - URLElement
struct SerieURLElement: Codable, Hashable {
    let type: String?
    let url: String?
}
