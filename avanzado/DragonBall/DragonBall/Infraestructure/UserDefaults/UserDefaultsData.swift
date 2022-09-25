//
//  UserDefaultsData.swift
//  DragonBall
//
//  Created by Victoria Aloy on 25/9/22.
//

import Foundation

private enum UserDefaultsKeys {
    static let opened = "opened"
}

class UserDefaultsData {
    private static let userDefaults = UserDefaults.standard
    
    static func isOpened() -> Bool {
        userDefaults.bool(forKey: UserDefaultsKeys.opened)
    }
    
    static func setOpened() {
        userDefaults.set(true, forKey: UserDefaultsKeys.opened)
    }
    
}
