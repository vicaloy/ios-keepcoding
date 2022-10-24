//
//  DetailData+State+Action.swift
//  marvel
//
//  Created by Victoria Aloy on 23/10/22.
//

import Foundation
import Combine

struct DetailData {
    var state: DetailState = .none
    var characters: Character = Character(id: nil, name: nil, description: nil, modified: nil, thumbnail: nil, resourceURI: nil, comics: nil, series: nil, stories: nil, events: nil, urls: nil)
    var series: [Serie] = []
    var page: Int = 0
    var position: Int = 0
    
    mutating func changeState(newState: DetailState) {
        state = newState
    }
    
    mutating func changePage(newPageNumber: Int){
        page = newPageNumber
    }
    
    mutating func changePosition(newPosition: Int){
        position = newPosition
    }
}

enum DetailAction {
    case reloadPage
    case nextPage(current: Serie)
    case newSearch
}

enum DetailState: Equatable {
    static func == (lhs: DetailState, rhs: DetailState) -> Bool {
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


