//
//  RootView.swift
//  marvel
//
//  Created by Victoria Aloy on 21/10/22.
//

import SwiftUI

struct RootView: View {
    
    @EnvironmentObject var rootViewModel: RootViewModel
    
    var body: some View {
        switch rootViewModel.currentScreen {
        case .home:
            HomeScreenView(viewModel: HomeViewModel(data: HomeData()))
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView().environmentObject(RootViewModel())
    }
}
