
import Foundation
import Combine

class SeriesViewModel: BaseViewModel<Serie>, BaseViewModelProtocol{
    typealias T = Serie
    
    let service: SeriesServiceProtocol
    
    init(data: BaseData<Serie>, service: SeriesServiceProtocol = SeriesService()) {
        self.service = service
        super.init(data: data)
    }
    
    func onPerformAction(action: BaseAction<Serie>) {
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
        service.execute(serieId: nil, page: currentPage, limit: 20)
            .sink(receiveCompletion: { completion in
                self.onRetrieveError(completion: completion)
                
            }){ response in
                self.onRetrieveSeries(response: response)
            }.store(in: &cancellableSet)
    }
    
    private func onNextPage(){
        currentPage = currentPage + 1
        onLoadData()
    }
    
    private func onRetrieveSeries(response: ResponseApi<SerieApi>){
        if let seriesApi = response.data?.results{
            
            let series = seriesApi.map{
                Serie(id: $0.id ?? 0, title: $0.title ?? "No title.", description: $0.description ?? "No description.", thumbnail:  URL(string: secureURLThumbnail(thumbnail: $0.thumbnail) ?? "https://www.google.com")!)
            }
            
            data.data.append(contentsOf: series)
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

