//
//  CharacterItem.swift
//  marvel
//
//  Created by Victoria Aloy on 21/10/22.
//

import SwiftUI

struct CharacterItemView: View {
    
    @ObservedObject var imageDownloader = ImageDownloader()
    
    private let character: Character
    
    init(character: Character) {
        self.character = character
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(LinearGradient(
                    gradient: .init(colors: [Color(MarvelColor.white), Color(MarvelColor.black)]),
                    startPoint: .init(x: 0.5, y: 0),
                    endPoint: .init(x: 0.5, y: 1)))
            
            
        }.frame(width: 450, height: 200)
        
    }
}

struct CharacterItemView_Previews: PreviewProvider {
    static var character = Character(
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
        urls: nil)
    static var previews: some View {
        CharacterItemView(character: character)
    }
}

