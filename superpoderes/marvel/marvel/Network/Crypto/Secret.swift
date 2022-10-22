//
//  Secret.swift
//  marvel
//
//  Created by Victoria Aloy on 21/10/22.
//

import Foundation
import CryptoKit

struct Secret {
    
    static private let privateKey = "ea0aac273173b69b4d45f586c8e80c6a0738d838"
    static let publicKey = "a28be6821380c7676975f8c1d82d8ebc"
    static let ts = String(Date().timeIntervalSince1970)
    
    static var md5: String {
        let digest = Insecure.MD5.hash(data: "\(ts)\(privateKey)\(publicKey)".data(using: .utf8) ?? Data())
        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }
}
