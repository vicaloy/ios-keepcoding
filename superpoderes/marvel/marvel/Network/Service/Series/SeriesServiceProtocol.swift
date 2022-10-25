

import Foundation
import Combine

protocol SeriesServiceProtocol {
    func execute(serieId: String?, page: Int,
                 limit: Int) -> AnyPublisher<ResponseApi<SerieApi>, APIError>
}
