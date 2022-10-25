
import SwiftUI

struct SeriesScreenView: View {
    
    @ObservedObject var viewModel: SeriesViewModel
    init(viewModel: SeriesViewModel) {
        self.viewModel = viewModel
        configNavTitleAppearance()
    }
    
    var body: some View {
            onContent()
    }
    
    private func onContent()->  some View {
        switch viewModel.data.state {
        case .none:
            return onClear().toAnyView()
        case .loading:
            return ProgressView().scaleEffect(2.0).toAnyView()
        case .error(let error):
            return Text(error.localizedDescription).foregroundColor(.red).toAnyView()
        case .loaded:
            return onList().toAnyView()
            
        }
    }
    
    
    private func onList()-> some View {
        NavigationView {
            List(viewModel.data.data) { serie in
                NavigationLink(destination: Text(serie.description)) {
                    SerieItemView(serie: serie).scaledToFill()
                }
                .navigationTitle("SERIES")
            }
        }
        .accentColor(Color(MarvelColor.white))
        
    }
    
    private func onClear() -> some View {
        Color
            .clear
            .onAppear{
                viewModel.onPerformAction(action: BaseAction.load)
            }
    }
    
    private func configNavTitleAppearance(){
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = MarvelColor.red
        
        let attrs: [NSAttributedString.Key: Any] = [
            .foregroundColor: MarvelColor.white,
            .font: UIFont(name: "Marvel-Regular", size: 100) ?? UIFont.monospacedSystemFont(ofSize: 100, weight: .black)
        ]
        
        appearance.largeTitleTextAttributes = attrs
        
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}

struct SerieScreenView_Previews: PreviewProvider {
   
    static var previews: some View {
        SeriesScreenView(viewModel: SeriesViewModel(data: BaseData<Serie>()))
    }
}
