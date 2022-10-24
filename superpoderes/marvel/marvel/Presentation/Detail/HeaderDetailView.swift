//
//  HeaderDetailCharacterView.swift
//  marvel
//
//  Created by Victoria Aloy on 23/10/22.
//

import SwiftUI

struct HeaderDetailView: View {
    var body: some View {
        onCharacterArea()
    }
    
    private func onCharacterArea() -> some View {
        return Group{
            onCharacterImage()
            Group{
                onBackgroundCharacterName()
                onCharacterName()
            }.padding(.top, 160)
        }
    }
    
    private func onCharacterImage()-> some View{
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
    
}

struct HeaderDetailView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderDetailView()
    }
}
