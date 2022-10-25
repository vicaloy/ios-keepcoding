

import Foundation

struct SerieApi: Codable, Hashable, Identifiable {
    static func == (lhs: SerieApi, rhs: SerieApi) -> Bool {
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
    let urls: [URLElementApi]?
    let startYear, endYear: Int?
    let rating, type: String?
    let modified: Date?
    let thumbnail: ThumbnailApi?
    let creators: CreatorApi?
    let characters: CharacterApi?
    let stories: StorieApi?
    let comics, events: CharacterApi?

    enum CodingKeys: String, CodingKey {
        case id, title
        case description = "description"
        case resourceURI, urls, startYear, endYear, rating, type, modified, thumbnail, creators, characters, stories, comics, events
    }
}
