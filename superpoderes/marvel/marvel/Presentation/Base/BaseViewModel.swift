

import Combine

class BaseViewModel<T>: ObservableObject{
    
    @Published
    var data: BaseData<T>
    var currentPage: Int = 0
    var cancellableSet: Set<AnyCancellable> = []
    
    init(data: BaseData<T>) {
        self.data = data
    }
    
    deinit {
        cancellableSet.removeAll()
    }
}

protocol BaseViewModelProtocol {
    associatedtype T
    func onPerformAction(action: BaseAction<T>)
    func onLoadData()
}

