//
//  HomeViewModel.swift
//  DragonBallApp
//
//  Created by Victoria Aloy on 28/7/22.
//

import Foundation

protocol HomeViewModelProtocol: AnyObject {
    var dataCount: Int { get }
    
    func onViewsLoaded()
    func getCharacter(for index: Int) -> DBCharacter?
    func onSelectedItem(at index: Int)
}

class HomeViewModel {
    
    private weak var viewDelegate: HomeViewProtocol?
    private var repository = DBCharacterRepository()
    private var dbCharacters: DBCharacters = []
    
    init(viewDelegate: HomeViewProtocol?) {
        self.viewDelegate = viewDelegate
    }
    
    private func loadData(){
        dbCharacters = repository.dbCharacterSample
    }
}

extension HomeViewModel: HomeViewModelProtocol {
    
    var dataCount: Int {
        dbCharacters.count
    }
    
    func onViewsLoaded() {
        loadData()
        viewDelegate?.updateDBCharacters()
    }
    
    func getCharacter(for index: Int) -> DBCharacter? {
        guard index < dbCharacters.count else { return nil }
        return dbCharacters[index]
    }
    
    func onSelectedItem(at index: Int) {
        guard let character = getCharacter(for: index) else { return }
        viewDelegate?.navigateToDetail(character: character)
    }
}
