
import Foundation
import Combine

protocol CharactersServiceProtocol {
    func execute(characterId: String?, searchTerm: String?, page: Int,
                 limit: Int) -> AnyPublisher<ResponseApi<CharacterApi>, APIError>
}
