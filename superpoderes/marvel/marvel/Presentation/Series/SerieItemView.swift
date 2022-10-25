
import SwiftUI

struct SerieItemView: View {
    
    private let serie: Serie
    
    init(serie: Serie) {
        self.serie = serie
    }
    
    var body: some View {
        onContent()
    }
    
    private func onContent() -> some View{
        ZStack {
            onCacheAsyncImage()
        }.overlay(alignment: .top, content: onTitle().toAnyView)
        
    }
    
    private func onTitle()-> some View{
        Text(serie.title)
            .frame(maxWidth: .infinity, alignment: .center)
            .font(.system(size: 28, weight: .black))
            .foregroundColor(Color(MarvelColor.white))
            .background(Color(MarvelColor.blackAlpha))
    }
    
    private func onCacheAsyncImage() -> some View{
        CacheAsyncImage(url: serie.thumbnail) { phase in
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
        image
            .resizable()
            .scaledToFill()
            .frame(maxWidth: .infinity, alignment: .center)
            
        
        
    }
    
    private func onBackgroundGradient()-> some View{
        RoundedRectangle(cornerRadius: 25, style: .continuous)
            .fill(LinearGradient(
                gradient: .init(colors: [Color(MarvelColor.white), Color(MarvelColor.black)]),
                startPoint: .init(x: 0.5, y: 0),
                endPoint: .init(x: 0.5, y: 1)))
    }
    
}

struct SerieItemView_Previews: PreviewProvider {
    static var serie = Serie(
        id:1,
        title: "Agent Brand",
        description: "Description",
        thumbnail: URL(string: "https://i.annihil.us/u/prod/marvel/i/mg/4/60/52695285d6e7e.jpg")!
    )
    static var previews: some View {
        SerieItemView(serie: serie)
    }
}

