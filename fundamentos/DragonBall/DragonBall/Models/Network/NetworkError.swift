//
//  NetworkError.swift
//  DragonBall
//
//  Created by Victoria Aloy on 17/7/22.
//

import Foundation

enum NetworkError: Error, Equatable {
    case malformedURL
    case dataFormatting
    case other
    case noData
    case errorCode(Int?)
    case tokenFormatError
    case decoding
}
