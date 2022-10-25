

import XCTest
@testable import Marvel
import Combine

final class SeriesViewModelTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoadData() throws {
        //Given
        let viewModel = SeriesViewModel(data: BaseData(), service: SeriesServiceMock())
        //When
        viewModel.onLoadData()
        //Then
        XCTAssertEqual(series, viewModel.data.data)
    }
    
    func testPerformLoadAction() throws {
        //Given
        let viewModel = SeriesViewModel(data: BaseData(), service: SeriesServiceMock())
        //When
        viewModel.onPerformAction(action: BaseAction.load)
        //Then
        XCTAssertEqual(series, viewModel.data.data)
    }
    
    func testPerformNextPageAction() throws {
        //Given
        let viewModel = SeriesViewModel(data: BaseData(), service: SeriesServiceMock())
        let page = viewModel.currentPage
        //When
        viewModel.onPerformAction(action: BaseAction.nextPage)
        //Then
        XCTAssertEqual(page + 1, viewModel.currentPage)
        XCTAssertEqual(series, viewModel.data.data)
    }

}



let series = [Serie(id: 1, title: "Title", description: "Description", thumbnail:  URL(string: "https://i.annihil.us/u/prod/marvel/i/mg/4/60/52695285d6e7e.jpg")!)]
let serieThumbnail = ThumbnailApi(path: "http://i.annihil.us/u/prod/marvel/i/mg/4/60/52695285d6e7e", thumbnailExtension: "jpg")
let serie = SerieApi(id: 1, title: "Title", description: "Description", resourceURI: nil, urls: nil, startYear: nil, endYear: nil, rating: nil, type: nil, modified: nil, thumbnail: serieThumbnail, creators: nil, characters: nil, stories: nil, comics: nil, events: nil)
let serieData = DataApi<SerieApi>(offset: 0, limit: 0, total: 0, count: 0, results: [serie])
let serieResponse = ResponseApi<SerieApi>(code: 200, status: "status", copyright: "copyright", attributionText: "attributionText", attributionHTML: "attributionHTML", etag: "etag", data: serieData)


class SeriesServiceMock: SeriesServiceProtocol {
    func execute(serieId: String?, page: Int, limit: Int) -> AnyPublisher<ResponseApi<SerieApi>, APIError> {
        return Future<ResponseApi<SerieApi>, APIError>{ promise in
            promise(.success(serieResponse))
        }.eraseToAnyPublisher()
    }
}
