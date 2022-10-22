//
//  HomeScreenView.swift
//  marvel
//
//  Created by Victoria Aloy on 20/10/22.
//

import SwiftUI

struct HomeScreenView: View {
    
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        content
    }
    
    private var content: some View {
        switch viewModel.data.state {
        case .none:
            return Color.clear.eraseToAnyView()
        case .loading:
            return ProgressView().scaleEffect(2.0).eraseToAnyView()
        case .error(let error):
            return Text(error.localizedDescription).eraseToAnyView()
        case .loaded:
            return CharactersListView(characters: $viewModel.data.characters,
                                      actionPerfomed: actionPerformed, position: $viewModel.data.position).eraseToAnyView()
        }
    }
    
    private func actionPerformed(action: HomeAction, current: Character) {
        viewModel.actionPerformed(action: action, current: current)
    }
    
}

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView(viewModel: HomeViewModel(data: HomeData()))
    }
}
