//
//  CharactersViewModel.swift
//  Marvel
//
//  Created by Victoria Aloy on 24/10/22.
//

import Combine
import Foundation

class CharactersViewModel: BaseViewModel<Character, ResponseApi<CharacterApi>>, BaseViewModelProtocol{
    typealias T = Character
    
    func onActionPerformed(action: BaseAction<Character>) {
        switch action {
        case BaseAction.load:
            onLoadData()
        case BaseAction.nextPage:
            onNextPage()
        default:
            print("default")
        }
    }
    
    func onLoadData() {
        data.changeState(newState: BaseState.loaded)
        (service as? CharactersService)?.execute(searchTerm: data.searchTerm.value, page: currentPage)
            .sink(receiveCompletion: { completion in
                self.onRetrieveError(completion: completion)
                
            }){ response in
                self.onRetrieveCharacters(response: response)
            }.store(in: &cancellableSet)
    }
    
    private func onNextPage(){
        currentPage = currentPage + 1
        onLoadData()
    }
    
    private func onRetrieveCharacters(response: ResponseApi<CharacterApi>){
        if let charactersApi = response.data?.results{
            
            let characters = charactersApi.map{
                Character(id: $0.id ?? 0, name: $0.name ?? "", thumbnail: URL(string: secureURLThumbnail(thumbnail: $0.thumbnail) ?? "https://www.google.com")!)
            }
            
            data.data.append(contentsOf: characters)
        }
    }
    
    private func onRetrieveError(completion: Subscribers.Completion<APIError>){
        if case .failure(let error) = completion {
            self.data.changeState(newState: .error(error))
        }
    }
    
    private func secureURLThumbnail(thumbnail: ThumbnailApi?) -> String?{
        if var url = thumbnail?.path{
            url = String(url)+"."+String(thumbnail?.thumbnailExtension ?? "")
            if(url.contains("https") == false){
                url.replace("http", with: "https")
            }
            return url
        }
        return nil
    }
    
    
    
}
