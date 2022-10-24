//
//  HomeScreenView.swift
//  marvel
//
//  Created by Victoria Aloy on 20/10/22.
//

import SwiftUI

struct HomeScreenView: View {
    
    @ObservedObject var viewModel: HomeViewModel
    @State var isScreenDisplayed = false
    
    var body: some View {
        content
    }
    
    private var content: some View {
        switch viewModel.data.state {
        case .none:
            return Color.clear.toAnyView()
        case .loading:
            return ProgressView().scaleEffect(2.0).toAnyView()
        case .error(let error):
            return Text(error.localizedDescription).foregroundColor(.red).toAnyView()
        case .loaded:
            return CharactersListView(characters: $viewModel.data.characters,
                                      actionPerfomed: actionPerformed, position: $viewModel.data.position).toAnyView()
            
        }
    }
    
    private func actionPerformed(action: HomeAction) {
        viewModel.actionPerformed(action: action)
    }
    
}

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView(viewModel: HomeViewModel(data: HomeData()))
    }
}
