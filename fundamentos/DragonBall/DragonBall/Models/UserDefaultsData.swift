//
//  UserDefaultsData.swift
//  DragonBall
//
//  Created by Victoria Aloy on 17/7/22.
//

import Foundation

private enum UserDefaultsKeys {
    static let tokenKey = "KCToken"
}

final class UserDefaultsData {
    private static let userDefaults = UserDefaults.standard
    
    static func getToken() -> String? {
        userDefaults.string(forKey: UserDefaultsKeys.tokenKey)
    }
    
    static func saveToken(token: String) {
        userDefaults.set(token, forKey: UserDefaultsKeys.tokenKey)
    }
    
    static func deleteToken() {
        userDefaults.removeObject(forKey: UserDefaultsKeys.tokenKey)
    }
}
