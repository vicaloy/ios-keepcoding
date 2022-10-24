//
//  SeriesListView.swift
//  marvel
//
//  Created by Victoria Aloy on 23/10/22.
//

import SwiftUI

struct SeriesListView: View {
    
    @Binding var series: [Serie]
    var actionPerfomed: ((DetailAction) -> Void)?
    @Binding var position: Int
    
    @State private var searchText = ""
    @State private var isNavigationBarHidden: Bool = false
    
    init(series: Binding<[Serie]>, actionPerfomed: ((DetailAction) -> Void)? = nil, position: Binding<Int>, searchText: String = "") {
        self._series = series
        self.actionPerfomed = actionPerfomed
        self._position = position
        self.searchText = searchText
    }
    
    var body: some View {
        List(series) { series in
            NavigationLink(destination: Text("Details")){
                Text("Row")
            }
            .isDetailLink(false)
            .navigationTitle("Inner list")
        }
        
    }
    
    private func onScrollCharacters() -> some View{
        return ScrollViewReader { proxy in
            onListCharacters(proxy: proxy)
            /*.searchable(text: $searchText, placement: .navigationBarDrawer)*/
        }
    }
    
    private func onListCharacters(proxy: ScrollViewProxy) -> some View{
        return List {
            ForEach(seriesFiltered, id: \.self) { serie in
                Text(serie.title ?? "No title")
                    .listRowBackground(Color.red.opacity(0))
            }
        }
        
    }
    
    
    var seriesFiltered: [Serie] {
        if searchText.isEmpty {
            return series
        } else {
            return series.filter { serie in
                (serie.title ?? "").contains(searchText)
            }
        }
    }
    
}

struct SeriesListView_Previews: PreviewProvider {
    
    static var series: Binding<[Serie]> = .constant([Serie(
        id: 1, title: "Ultimate Fantastic Four (2003 - 2009)", description: "The Ultimate line takes classic Marvel characters and ideas and infuses them with new concepts and in radically fresh ways, without the ties to continuity.<br>\r\nUtlimate Fantastic Four focuses on the young geniuses of the FF as they come to grips with a wild world. Great reading for everyone from the newbie science geek to the veteran Marvel zombie.", resourceURI: nil, urls: nil, startYear: nil, endYear: nil, rating: nil, type: nil, modified: nil, thumbnail: SerieThumbnail(path: "https://i.annihil.us/u/prod/marvel/i/mg/6/c0/51310e8e788bf.jpg", thumbnailExtension: "jpg"), creators: nil, characters: nil, stories: nil, comics: nil, events: nil)])
    
    static var pos: Binding<Int> = .constant(0)
    
    static var previews: some View {
        SeriesListView(series: series, position: pos)
    }
}

