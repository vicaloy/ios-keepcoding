//
//  HomeData+State+Action.swift
//  marvel
//
//  Created by Victoria Aloy on 21/10/22.
//

import Foundation
import Combine

struct HomeData {
    var characters: [Character] = []
    var state: HomeState = .none
    var page: Int = 0
    var position: Int = 0
    var searchTerm: CurrentValueSubject<String, Never> = CurrentValueSubject<String, Never>("")
    
    mutating func changeState(newState: HomeState) {
        state = newState
    }
    
    mutating func changePage(newPageNumber: Int){
        page = newPageNumber
    }
    
    mutating func changePosition(newPosition: Int){
        position = newPosition
    }
}

enum HomeAction {
    case reloadPage
    case nextPage
    case newSearch
}

enum HomeState: Equatable {
    static func == (lhs: HomeState, rhs: HomeState) -> Bool {
        switch(lhs, rhs){
        case(.none, .none):
            return true
        case (.loading, .loading):
            return true
        case (.loaded, .loaded):
            return true
        default:
            return false
            
        }
    }
    
    case none
    case loading
    case loaded
    case error(Error)
}


