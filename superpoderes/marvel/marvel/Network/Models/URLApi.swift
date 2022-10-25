

import Foundation

struct URLElementApi: Codable, Hashable {
    let type: URLTypeApi?
    let url: String?
}

enum URLTypeApi: String, Codable {
    case comiclink = "comiclink"
    case detail = "detail"
    case wiki = "wiki"
}
