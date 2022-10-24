//
//  ThumbnailApi.swift
//  Marvel
//
//  Created by Victoria Aloy on 24/10/22.
//

import Foundation

struct ThumbnailApi: Codable, Hashable {
    let path: String?
    let thumbnailExtension: String?

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}
