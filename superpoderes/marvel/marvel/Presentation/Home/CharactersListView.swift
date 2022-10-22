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
    
    var body: some View {
        NavigationView {
            ScrollViewReader { proxy in
                List {
                    ForEach(charactersFiltered, id: \.self) { character in
                        NavigationLink(destination: Text(character.name ?? "No name")) {
                            Text(character.name ?? "No name")
                        }
                        .onAppear(){
                            actionPerfomed?(.nextPage, character)
                            proxy.scrollTo(position)
                        }
                    }
                }
                .searchable(text: $searchText)
                .navigationTitle("Characters")
            }
            
        }
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
    static var previews: some View {
        VStack{}
    }
}
