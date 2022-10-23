//
//  AsyncImageView.swift
//  marvel
//
//  Created by Victoria Aloy on 23/10/22.
//

import SwiftUI

struct AsyncImageView: View {
    var path: String
    
    var body: some View {
        AsyncImage(url: URL(string: path), transaction: .init(animation: .spring(response: 1.6))) { phase in
            onImageLoad(phase: phase)
        }
    }
    
    private func onImageLoad(phase: AsyncImagePhase)-> some View{
        switch phase {
        case .empty:
            return ProgressView().toAnyView()
        case .success(let image):
            return retireveImage(image: image).toAnyView()
        case .failure:
            return retrieveTextError(text:"Network error.").toAnyView()
        @unknown default:
            return retrieveTextError(text: "Unknown error.").toAnyView()
        }
    }
    
    private func retireveImage(image: Image)-> some View{
        return image
            .resizable()
            .frame(width: 450, height: 200)
            .padding(.bottom, 16)
            .aspectRatio(contentMode: .fill)
    }
    
    private func retrieveTextError(text: String)->some View{
        return Text(text)
            .foregroundColor(.red)
    }
}

struct AsyncImageView_Previews: PreviewProvider {
    static var previews: some View {
        AsyncImageView(path: "https://i.annihil.us/u/prod/marvel/i/mg/3/20/5232158de5b16.jpg")
    }
}
