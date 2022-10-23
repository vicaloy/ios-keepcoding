//
//  marvelApp.swift
//  marvel
//
//  Created by Victoria Aloy on 18/10/22.
//

import SwiftUI

@main
struct marvelApp: App {
    
    @StateObject var rootViewModel = RootViewModel()
    
    init(){
        Font.registerCustom()
    }
    
    var body: some Scene {
        WindowGroup {
            RootView().environmentObject(rootViewModel)
        }
    }
    /*let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }*/
}
