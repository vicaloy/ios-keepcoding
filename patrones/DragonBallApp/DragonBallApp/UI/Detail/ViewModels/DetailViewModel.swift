//
//  DetailViewModel.swift
//  DragonBallApp
//
//  Created by Victoria Aloy on 29/7/22.
//

import Foundation

protocol DetailViewModelProtocol: AnyObject {
    var character: DBCharacter { get }
    
    func onViewsLoaded()
}

class DetailViewModel {
    private(set) var character: DBCharacter
    private var viewDelegate: DetailViewProtocol?
    
    required init(viewDelegate: DetailViewProtocol?, character: DBCharacter) {
        self.character = character
        self.viewDelegate = viewDelegate
    }
}

extension DetailViewModel: DetailViewModelProtocol {
    
    func onViewsLoaded() {
        if character is Hero{
            viewDelegate?.update(hero: character as! Hero)
        }else if character is Villain{
            viewDelegate?.update(villain: character as! Villain)
        }
    }
}
