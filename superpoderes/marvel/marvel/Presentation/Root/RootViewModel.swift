

import SwiftUI

class RootViewModel: ObservableObject {
    
    @Published var currentScreen: Screen = .characters
    
}

enum Screen {
    case characters
}
