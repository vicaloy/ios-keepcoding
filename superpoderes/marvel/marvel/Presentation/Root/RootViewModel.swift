//
//  RootViewModel.swift
//  marvel
//
//  Created by Victoria Aloy on 21/10/22.
//

import SwiftUI

class RootViewModel: ObservableObject {
    
    @Published var currentScreen: Screen = .home
    
}

enum Screen {
    case home
}
