//
//  ResponseApi.swift
//  Marvel
//
//  Created by Victoria Aloy on 24/10/22.
//

import Foundation

struct ResponseApi<T:Codable>: Codable {
    let code: Int?
    let status: String?
    let copyright: String?
    let attributionText: String?
    let attributionHTML: String?
    let etag: String?
    var data: DataApi<T>?
}

struct DataApi<T:Codable>: Codable {
    let offset, limit, total, count: Int?
    var results: [T]?
}
