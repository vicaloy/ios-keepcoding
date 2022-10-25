

import SwiftUI

struct CharactersScreenView: View {
    
    @ObservedObject var viewModel: CharactersViewModel
    
    init(viewModel: CharactersViewModel) {
        self.viewModel = viewModel
        configNavTitleAppearance()
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
            return onNavigation().toAnyView()
            
        }
    }
    
    private func onClear() -> some View {
        Color
            .clear
            .onAppear{
                viewModel.onPerformAction(action: BaseAction.load)
            }
    }
    
    private func onNavigation() -> some View{
        NavigationView {
            List(viewModel.data.data) { character in
                onLink(character: character).scaledToFill()
            }
            .navigationTitle("CHARACTERS")
            
        }
        .accentColor(Color(MarvelColor.white))
    }
    
    private func onLink(character: Character) -> some View{
        NavigationLink(destination: CharacterDetailView(character: character)) {
            CharacterItemView(character: character)
        }
        .onAppear{
            loadNextPage(character: character)
        }
    }
    
    
}

extension CharactersScreenView{
    
    private func isNextPageNeeded(character: Character)-> Bool{
        viewModel.data.data.firstIndex(of:character) == viewModel.data.data.count-4
    }
    
    private func loadNextPage(character: Character){
        if isNextPageNeeded(character: character) {
            viewModel.onPerformAction(action: BaseAction.nextPage)
        }
    }
    
    private func configNavTitleAppearance(){
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = MarvelColor.red
        
        let attrs: [NSAttributedString.Key: Any] = [
            .foregroundColor: MarvelColor.white,
            .font: UIFont(name: "Marvel-Regular", size: 100) ?? UIFont.monospacedSystemFont(ofSize: 100, weight: .black)
        ]
        
        appearance.largeTitleTextAttributes = attrs
        
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
}

struct CharactersScreenView_Previews: PreviewProvider {
    static var character = Character(
        id:1,
        name: "Agent Brand",
        thumbnail: URL(string: "https://i.annihil.us/u/prod/marvel/i/mg/4/60/52695285d6e7e.jpg")!,
        description: "Description"
    )
    
    static var previews: some View {
        CharactersScreenView(viewModel: CharactersViewModel(data: BaseData<Character>()))
    }
}
