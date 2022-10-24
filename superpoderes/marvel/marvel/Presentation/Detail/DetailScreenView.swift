//
//  CharacterDetailView.swift
//  marvel
//
//  Created by Victoria Aloy on 23/10/22.
//

import SwiftUI

struct DetailScreenView: View {
    
    @ObservedObject var viewModel: DetailViewModel
    @Binding var isNavigationBarHidden: Bool
    
    var body: some View {
        ZStack{
        
        }
        .overlay(HeaderDetailView(), alignment: .top)
        .onAppear {
            self.isNavigationBarHidden = true
        }
        
    }
    
    private func onContentArea() -> some View {
        return Group{
            Group{
                onBackgroundCharacterName()
                onCharacterName()
            }.padding(.top, 160)
        }
    }
    
    private func onComicImage()-> some View{
        return CacheAsyncImage(url: URL(string: "https://i.annihil.us/u/prod/marvel/i/mg/4/60/52695285d6e7e.jpg")!) { phase in
            onImageDownloaded(phase: phase)
        }
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
            .frame(width: 180, height: 180)
            .clipShape(Circle())
            .shadow(radius: 10)
            .overlay(Circle().stroke(Color(MarvelColor.black), lineWidth: 5))
            .aspectRatio(contentMode: .fill)
    }
    
    private func onCharacterName()-> some View{
        return Text("Agent Brand")
            .font(.system(size: 36)).fontWeight(Font.Weight.black)
            .foregroundColor(Color(MarvelColor.white))
    }
    
    private func onBackgroundCharacterName()-> some View{
        return RoundedRectangle(cornerRadius: 0, style: .continuous)
            .fill(Color(MarvelColor.blackAlpha))
            .frame(width: 600, height: 80)
    }
    
    
    private func onBackgroundGradient()-> some View{
        return RoundedRectangle(cornerRadius: 0, style: .continuous)
            .fill(LinearGradient(
                gradient: .init(colors: [Color(MarvelColor.red), Color(MarvelColor.red), Color(MarvelColor.black)]),
                startPoint: .init(x: 0.5, y: 0),
                endPoint: .init(x: 0.5, y: 1)))
    }
    
}

struct DetailScreenView_Previews: PreviewProvider {
    
    static var isNavigationBarHidden: Binding<Bool> = .constant(true)
    
    static var previews: some View {
        
        let character = Character(
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
        
        DetailScreenView(viewModel: DetailViewModel(data: DetailData(), character: character), isNavigationBarHidden: isNavigationBarHidden)
    }
}
