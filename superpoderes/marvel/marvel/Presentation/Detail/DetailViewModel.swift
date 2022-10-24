//
//  DetailViewModel.swift
//  marvel
//
//  Created by Victoria Aloy on 23/10/22.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {
    
    @Published
    var data: DetailData
    
    private var character: Character
    private var service: SeriesService
    private var cancellableSet: Set<AnyCancellable> = []
    
    init(data: DetailData, character: Character, service: SeriesService = SeriesService()) {
        self.data = data
        self.character = character
        self.service = service
        self.data.changeState(newState: .loading)
    }
    
    deinit {
        cancellableSet.removeAll()
    }
    
    func actionPerformed(action: DetailAction) {
        if case DetailAction.nextPage(let current) = action {
            if hasLoadNextPage(current: current){
                data.changePage(newPageNumber: data.page + 1)
                loadSeries()
            }
        }
    }
    
    
    private func loadSeries(serieId: String? = nil){
        self.data.changeState(newState: DetailState.loaded)
        self.service.execute(serieId: serieId, page: self.data.page)
            .sink(receiveCompletion: { completion in
                self.retrieveError(completion: completion)
            }){ response in
                self.retrieveSeries(response: response)
            }.store(in: &cancellableSet)
    }
    
    private func retrieveSeries(response: SerieResponse){
        if let series = response.data?.results{
            self.data.series.append(contentsOf: series)
            self.data.position = positionOnPageChange()
        }
    }
    
    private func retrieveError(completion: Subscribers.Completion<APIError>){
        if case .failure(let error) = completion {
            print(error.localizedDescription)
            self.data.changeState(newState: .error(error))
        }
    }
    
    private func positionOnPageChange() -> Int{
        var position = 0
        if(self.data.page>0){
            let limitPage = self.data.series.count/self.data.page
            position = limitPage * (self.data.page - 1)
        }
        
        return position
    }
    
    private func hasLoadNextPage(current: Serie) -> Bool {
        let indexShown = data.series.endIndex - 3
        if indexShown > 3 && data.series[indexShown] == current{
            return true
        }else{
            return false
        }
    }
    
    private func loadNextPage(current: Serie){
        if hasLoadNextPage(current: current){
            data.changePage(newPageNumber: data.page + 1)
            loadSeries()
        }
    }
    
}
