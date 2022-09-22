//
//  DetailViewModel.swift
//  DragonBall
//
//  Created by Victoria Aloy on 21/9/22.
//

import Foundation

protocol DetailViewModelProtocol: AnyObject {
    func onViewsLoaded()
}

class DetailViewModel{
    private weak var viewDelegate: DetailViewProtocol?
    private let hero: Hero
    
    init(viewDelegate: DetailViewProtocol?, hero: Hero) {
        self.viewDelegate = viewDelegate
        self.hero = hero
    }
    
}

extension DetailViewModel: DetailViewModelProtocol {
    
    func onViewsLoaded() {
        self.viewDelegate?.onBindHero(hero: self.hero)
    }
}
