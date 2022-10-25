
import Foundation

struct StorieApi: Codable, Hashable {
    static func == (lhs: StorieApi, rhs: StorieApi) -> Bool {
        lhs.available == rhs.available &&
        lhs.collectionURI == rhs.collectionURI &&
        lhs.items == rhs.items &&
        lhs.returned == rhs.returned
    }
    
    let available: Int?
    let collectionURI: String?
    let items: [StorieItemApi]?
    let returned: Int?
}

struct StorieItemApi: Codable, Hashable {
    let resourceURI: String?
    let name: String?
    let type: String?
}
