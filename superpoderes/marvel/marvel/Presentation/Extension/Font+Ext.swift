//
//  Font+Ext.swift
//  marvel
//
//  Created by Victoria Aloy on 22/10/22.
//

import Foundation
import SwiftUI
import UIKit


extension Font {
    static func registerCustom() {
        self.register(name: "Marvel-Regular", withExtension: "ttf")
    }
    static func register(name: String, withExtension: String) {
        let fontURL = Bundle.main.url(forResource: name, withExtension: withExtension)!
        var error: Unmanaged<CFError>?
        CTFontManagerRegisterFontsForURL(fontURL as CFURL, .process, &error)
        if let error = error {
            print(error.takeUnretainedValue())
        }
    }
}
