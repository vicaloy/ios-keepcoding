//
//  MarvelApp.swift
//  Marvel
//
//  Created by Victoria Aloy on 24/10/22.
//

import SwiftUI

@main
struct MarvelApp: App {
    @StateObject var rootViewModel = RootViewModel()
    
    init(){
        Font.registerCustom()
    }
    
    var body: some Scene {
        WindowGroup {
            RootView().environmentObject(rootViewModel)
        }
    }
}
