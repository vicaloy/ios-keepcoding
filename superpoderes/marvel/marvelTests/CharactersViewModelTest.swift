

import XCTest
@testable import Marvel
import Combine

final class CharactersViewModelTest: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testLoadData() throws {
        //Given
        let viewModel = CharactersViewModel(data: BaseData(), service: CharacterServiceMock())
        //When
        viewModel.onLoadData()
        //Then
        XCTAssertEqual(characters, viewModel.data.data)
    }
    
    func testPerformLoadAction() throws {
        //Given
        let viewModel = CharactersViewModel(data: BaseData(), service: CharacterServiceMock())
        //When
        viewModel.onPerformAction(action: BaseAction.load)
        //Then
        XCTAssertEqual(characters, viewModel.data.data)
    }
    
    func testPerformNextPageAction() throws {
        //Given
        let viewModel = CharactersViewModel(data: BaseData(), service: CharacterServiceMock())
        let page = viewModel.currentPage
        //When
        viewModel.onPerformAction(action: BaseAction.nextPage)
        //Then
        XCTAssertEqual(page + 1, viewModel.currentPage)
        XCTAssertEqual(characters, viewModel.data.data)
    }


}

let characters = [Character(id: 1, name: "Name", thumbnail: URL(string: "https://i.annihil.us/u/prod/marvel/i/mg/4/60/52695285d6e7e.jpg")!, description: "Description")]

let characterThumbnail = ThumbnailApi(path: "http://i.annihil.us/u/prod/marvel/i/mg/4/60/52695285d6e7e", thumbnailExtension: "jpg")
let character = CharacterApi(id: 1, name: "Name", description: "Description", modified: nil, thumbnail: characterThumbnail, resourceURI: nil, comics: nil, series: nil, stories: nil, events: nil, urls: nil)
let characterData = DataApi<CharacterApi>(offset: 0, limit: 0, total: 0, count: 0, results: [character])
let characterResponse = ResponseApi<CharacterApi>(code: 200, status: "status", copyright: "copyright", attributionText: "attributionText", attributionHTML: "attributionHTML", etag: "etag", data: characterData)


class CharacterServiceMock: CharactersServiceProtocol {
    
    func execute(characterId: String?, searchTerm: String?, page: Int, limit: Int) -> AnyPublisher<ResponseApi<CharacterApi>, APIError>
    {
        return Future<ResponseApi<CharacterApi>, APIError>{ promise in
            promise(.success(characterResponse))
        }.eraseToAnyPublisher()
    }
}

