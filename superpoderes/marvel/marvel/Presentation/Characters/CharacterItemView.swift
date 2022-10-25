
import SwiftUI

struct CharacterItemView: View {
    
    private let character: Character
    
    init(character: Character) {
        self.character = character
    }
    
    var body: some View {
        content()
    }
    
    private func content() -> some View{
        GeometryReader { geometry in
            onCacheAsyncImage(geometry: geometry)
            onTitle(geometry: geometry)
        }
        
    }
    
    private func onTitle(geometry: GeometryProxy)-> some View{
        Text(character.name)
            .font(.system(size: 36, weight: .black))
            .foregroundColor(Color(MarvelColor.white))
            .frame(width: geometry.size.width, height: 80, alignment: .center)
            .background(Color(MarvelColor.blackAlpha))
    }
    
    private func onCacheAsyncImage(geometry: GeometryProxy) -> some View{
        CacheAsyncImage(url: character.thumbnail) { phase in
            onImageDownloaded(geometry:geometry, phase: phase)
        }
    }
    
    private func onImageDownloaded(geometry: GeometryProxy, phase: AsyncImagePhase)-> some View{
        switch phase {
        case .empty:
            return ProgressView().toAnyView()
        case .success(let image):
            return onResizeImage(geometry: geometry, image: image).toAnyView()
        case .failure:
            return Text("Network error.").foregroundColor(.red).toAnyView()
        @unknown default:
            return Text("Unknown error.").foregroundColor(.red).toAnyView()
        }
    }
    
    private func onResizeImage(geometry: GeometryProxy, image: Image) -> some View{
        image
            .resizable()
            .scaledToFill()
            .frame(width: geometry.size.width)
        
        
    }
    
    private func onBackgroundGradient()-> some View{
        RoundedRectangle(cornerRadius: 25, style: .continuous)
            .fill(LinearGradient(
                gradient: .init(colors: [Color(MarvelColor.white), Color(MarvelColor.black)]),
                startPoint: .init(x: 0.5, y: 0),
                endPoint: .init(x: 0.5, y: 1)))
    }
    
}

struct CharacterItemView_Previews: PreviewProvider {
    static var character = Character(
        id:1,
        name: "Agent Brand",
        thumbnail: URL(string: "https://i.annihil.us/u/prod/marvel/i/mg/4/60/52695285d6e7e.jpg")!,
        description: "Description"
    )
    static var previews: some View {
        CharacterItemView(character: character)
    }
}

