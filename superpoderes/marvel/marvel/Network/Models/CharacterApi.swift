

import Foundation

struct CharacterApi: Codable, Hashable, Identifiable {
    static func == (lhs: CharacterApi, rhs: CharacterApi) -> Bool {
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
    let thumbnail: ThumbnailApi?
    let resourceURI: String?
    let comics, series: ComicApi?
    let stories: StorieApi?
    let events: ComicApi?
    let urls: [URLElementApi]?

    enum CodingKeys: String, CodingKey {
        case id, name
        case description
        case modified, thumbnail, resourceURI, comics, series, stories, events, urls
    }
}
