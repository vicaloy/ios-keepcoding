//
//  ApiError.swift
//  marvel
//
//  Created by Victoria Aloy on 21/10/22.
//

import Foundation

public enum APIError: Error {
    case urlError
    case internalError
    case decodingError
    case serverError(code: Int, message: String)
}
