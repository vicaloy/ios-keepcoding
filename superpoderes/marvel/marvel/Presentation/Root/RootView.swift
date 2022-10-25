

import SwiftUI

struct RootView: View {
    
    @EnvironmentObject var rootViewModel: RootViewModel

    
    var body: some View {
        
        TabView{
            CharactersScreenView(viewModel: CharactersViewModel(data: BaseData<Character>()))
                .tabItem{
                    Label("Characters",systemImage: "person.fill")
                }
            SeriesScreenView(viewModel: SeriesViewModel(data: BaseData<Serie>(), service: SeriesService()))
                .tabItem{
                    Label("Series",systemImage: "tv.fill")
                }
                   
        }.accentColor(Color(MarvelColor.red))
        
    }
    
}
    
    struct RootView_Previews: PreviewProvider {
        static var previews: some View {
            RootView().environmentObject(RootViewModel())
        }
    }
