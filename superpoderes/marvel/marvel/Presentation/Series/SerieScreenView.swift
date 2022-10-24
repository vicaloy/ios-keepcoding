//
//  SerieScreenView.swift
//  Marvel
//
//  Created by Victoria Aloy on 24/10/22.
//

import SwiftUI

struct SerieScreenView: View {
    
    @ObservedObject var viewModel: SeriesViewModel
    let character: Character
    
    init(viewModel: SeriesViewModel, character: Character) {
        self.viewModel = viewModel
        self.character = character
    }
    
    var body: some View {
            onContent()
    }
    
    private func onContent()->  some View {
        switch viewModel.data.state {
        case .none:
            return onClear().toAnyView()
        case .loading:
            return ProgressView().scaleEffect(2.0).toAnyView()
        case .error(let error):
            return Text(error.localizedDescription).foregroundColor(.red).toAnyView()
        case .loaded:
            return onHeaderList().toAnyView()
            
        }
    }
    
    private func onHeaderList()-> some View{
        VStack{
            HeaderSerieView(character: character)
            onList()
            
        }
    }
    
    private func onList()-> some View {
        List(viewModel.data.data) { serie in
            NavigationLink(destination: Text(serie.description)) {
                SerieItemView(serie: serie)
            }
            .navigationTitle("SERIES")
        }
    }
    
    private func onClear() -> some View {
        Color
            .clear
            .onAppear{
                viewModel.onActionPerformed(action: BaseAction.load)
            }
    }
}

struct SerieScreenView_Previews: PreviewProvider {
    static var character = Character(
        id:1,
        name: "Agent Brand",
        thumbnail: URL(string: "https://i.annihil.us/u/prod/marvel/i/mg/4/60/52695285d6e7e.jpg")!
    )
    static var previews: some View {
        SerieScreenView(viewModel: SeriesViewModel(data: BaseData<Serie>(), service: SeriesService()), character: character)
    }
}
