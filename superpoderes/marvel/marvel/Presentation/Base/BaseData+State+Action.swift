//
//  BaseData+State+Action.swift
//  Marvel
//
//  Created by Victoria Aloy on 24/10/22.
//

import Combine

struct BaseData<T>{
    var data: [T] = []
    var state: BaseState = .none
    var page: Int = 0
    
    var searchTerm: CurrentValueSubject<String, Never> = CurrentValueSubject<String, Never>("")
    
    mutating func changeState(newState: BaseState) {
        state = newState
    }
    
    mutating func changePage(newPageNumber: Int){
        page = newPageNumber
    }
}

enum BaseAction<T>{
    case nextPage
    case clickItem(item: T)
    case searchTerm
    case load
}

enum BaseState: Equatable {
    static func == (lhs: BaseState, rhs: BaseState) -> Bool {
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
