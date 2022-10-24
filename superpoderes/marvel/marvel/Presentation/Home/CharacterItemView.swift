//
//  CharacterItem.swift
//  marvel
//
//  Created by Victoria Aloy on 21/10/22.
//

import SwiftUI

struct CharacterItemView: View {
    
    private let character: Character
    
    init(character: Character) {
        self.character = character
    }
    
    var body: some View {
        ZStack {
            onBackgroundGradient()
            CacheAsyncImage(url: URL(string: character.thumbnail?.path ?? "https:www.google.com")!) { phase in
                onImageDownloaded(phase: phase)
            }
            
        }
        .overlay(onTitleArea(), alignment: .bottom)
        .frame(width: 450, height: 300)
        .padding(.bottom, 16)
        
    }
    
    private func onImageDownloaded(phase: AsyncImagePhase)-> some View{
        switch phase {
        case .empty:
            return ProgressView().toAnyView()
        case .success(let image):
            return onResizeImage(image: image).toAnyView()
        case .failure:
            return Text("Network error.").foregroundColor(.red).toAnyView()
        @unknown default:
            return Text("Unknown error.").foregroundColor(.red).toAnyView()
        }
    }
    
    private func onResizeImage(image: Image) -> some View{
        return image.resizable()
            .frame(width: 450, height: 300)
            .cornerRadius(25)
            .padding(.bottom, 16)
            .aspectRatio(contentMode: .fill)
    }
    
    private func onBackgroundGradient()-> some View{
        return RoundedRectangle(cornerRadius: 25, style: .continuous)
            .fill(LinearGradient(
                gradient: .init(colors: [Color(MarvelColor.white), Color(MarvelColor.black)]),
                startPoint: .init(x: 0.5, y: 0),
                endPoint: .init(x: 0.5, y: 1)))
    }
    
    private func onTitleArea() -> some View {
        return Group{
            onBackgroundTitle()
            onTitle()
        }
    }
    
    private func onTitle()-> some View{
        return Text(character.name ?? "No name")
            .font(.system(size: 36)).fontWeight(Font.Weight.black)
            .foregroundColor(Color(MarvelColor.white))
    }
    
    private func onBackgroundTitle()-> some View{
        return RoundedRectangle(cornerRadius: 25, style: .continuous)
            .fill(Color(MarvelColor.blackAlpha))
            .frame(width: 450, height: 80)
    }
}

struct CharacterItemView_Previews: PreviewProvider {
    static var character = Character(
        id:1,
        name: "Agent Brand",
        description: nil,
        modified: nil,
        thumbnail: CharacterThumbnail(path: "https://i.annihil.us/u/prod/marvel/i/mg/4/60/52695285d6e7e.jpg", thumbnailExtension: "jpg"),
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

