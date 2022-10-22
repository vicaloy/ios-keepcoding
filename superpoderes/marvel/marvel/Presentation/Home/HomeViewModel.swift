//
//  HomeViewModel.swift
//  marvel
//
//  Created by Victoria Aloy on 21/10/22.
//

import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    
    @Published
    var data: HomeData
    
    var service: CharactersService
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    init(service: CharactersService = CharactersService(), data: HomeData) {
        self.service = service
        self.data = data
        self.data.changeState(newState: .loading)
        self.loadCharacters()
    }
    
    deinit {
        cancellableSet.removeAll()
    }
    
    func actionPerformed(action: HomeAction, current: Character) {
        if case HomeAction.nextPage = action {
            if hasLoadNextPage(current: current){
                data.changePage(newPageNumber: data.page + 1)
                loadCharacters()
            }
        }
    }
    
    
    private func loadCharacters(searchTerm: CurrentValueSubject<String, Never> = CurrentValueSubject<String, Never>("")){
        self.data.changeState(newState: HomeState.loaded)
        self.service.execute(searchTerm: searchTerm.value, page: self.data.page)
            .sink(receiveCompletion: { completion in
              self.retrieveError(completion: completion)
              
            }){ response in
                self.retrieveCharacters(response: response, searchTerm: searchTerm)
            }.store(in: &cancellableSet)
        
        
    }
    
    private func hasLoadNextPage(current: Character) -> Bool {
        let indexShown = data.characters.endIndex - 3
        if indexShown > 3 && data.characters[indexShown] == current{
            return true
        }else{
            return false
        }
    }
    
    private func positionOnPageChange() -> Int{
        var position = 0
        if(self.data.page>0){
            let limitPage = self.data.characters.count/self.data.page
            position = limitPage * (self.data.page - 1)
        }
       
        return position
    }
    
    private func retrieveCharacters(response: CharacterResponse, searchTerm: CurrentValueSubject<String, Never>){
        if let characters = response.data?.results{
            self.data.characters.append(contentsOf: characters)
            self.data.position = positionOnPageChange()
        }
    }
    
    private func retrieveError(completion: Subscribers.Completion<APIError>){
        if case .failure(let error) = completion {
            self.data.changeState(newState: .error(error))
        }
    }
    
}

