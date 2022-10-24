//
//  BaseViewModel.swift
//  Marvel
//
//  Created by Victoria Aloy on 24/10/22.
//

import Combine

class BaseViewModel<T, S: Decodable>: ObservableObject{
    
    @Published
    var data: BaseData<T>
    
    var cancellableSet: Set<AnyCancellable> = []
    var currentPage: Int = 0
    var service: BaseService<S>
    
    init(data: BaseData<T>, service: BaseService<S>) {
        self.data = data
        self.service = service
    }
    
    deinit {
        cancellableSet.removeAll()
    }
}

protocol BaseViewModelProtocol {
    associatedtype T
    func onActionPerformed(action: BaseAction<T>)
    func onLoadData()
}

