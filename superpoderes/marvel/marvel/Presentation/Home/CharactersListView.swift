//
//  CharactersListView.swift
//  marvel
//
//  Created by Victoria Aloy on 21/10/22.
//

import SwiftUI

struct CharactersListView: View {
    
    @Binding var characters: [Character]
    var actionPerfomed: ((HomeAction, Character) -> Void)?
    @Binding var position: Int
    
    @State private var searchText = ""
    @State private var isNavigationBarHidden: Bool = false
    
    init(characters: Binding<[Character]>, actionPerfomed: ((HomeAction, Character) -> Void)? = nil, position: Binding<Int>, searchText: String = "") {
        self._characters = characters
        self.actionPerfomed = actionPerfomed
        self._position = position
        self.searchText = searchText
        configureNavView()
    }
    
    var body: some View {
        NavigationView {
            onScrollCharacters()
                .navigationBarHidden(self.isNavigationBarHidden)
                .onAppear {
                    self.isNavigationBarHidden = false
                }
                
        }
    }
    
    private func configureNavView(){
        setNavViewBackground()
        setNavViewAppearance()
    }
    
    private func onScrollCharacters() -> some View{
        return ScrollViewReader { proxy in
            onListCharacters(proxy: proxy)
            /*.searchable(text: $searchText, placement: .navigationBarDrawer)*/
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        onMarvelText()
                    }
                }
                .padding(.top, 90)
                .background(Color(MarvelColor.red))
        }
    }
    
    private func onListCharacters(proxy: ScrollViewProxy) -> some View{
        return List {
            ForEach(charactersFiltered, id: \.self) { character in
                onCharacterNavigation(character: character, proxy: proxy)
                    .listRowBackground(Color.red.opacity(0))
            }
        }
        
    }
    
    
    private func onCharacterNavigation(character: Character, proxy: ScrollViewProxy) -> some View{
        return NavigationLink(destination: CharacterDetailView(isNavigationBarHidden: self.$isNavigationBarHidden)) {
            CharacterItemView(character: character)
                
        }
        .onAppear(){
            actionPerfomed?(.nextPage, character)
            proxy.scrollTo(position)
        }
    }
    
    private func onMarvelText()-> some View {
        return Text("MARVEL")
            .font(.custom("Marvel-Regular", size: 120))
            .foregroundColor(Color(MarvelColor.white))
            .accessibilityAddTraits(.isHeader)
            .background(Color(MarvelColor.red))
            .padding(.top, 100)
        
    }
    
    
    var charactersFiltered: [Character] {
        if searchText.isEmpty {
            return characters
        } else {
            return characters.filter { character in
                (character.name ?? "").contains(searchText)
            }
        }
    }
    
}

struct CharactersListView_Previews: PreviewProvider {
    
    static var characters: Binding<[Character]> = .constant([Character(
        id:1,
        name: "Nombre",
        description: nil,
        modified: nil,
        thumbnail: nil,
        resourceURI: nil,
        comics:nil,
        series: nil,
        stories: nil,
        events: nil,
        urls: nil)])
    
    static var pos: Binding<Int> = .constant(0)
    
    static var previews: some View {
        CharactersListView(characters: characters, position: pos)
    }
}
