

import Foundation
import Combine

class BaseService<T: Decodable> {
    
    func buildRequest(url: URL, httpMethod: HttpMethod) -> AnyPublisher<T, APIError>{
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let decoder = decode(request: request)
        return publish(request: request, decoder: decoder)
    }
    
    func decode(request: URLRequest) -> JSONDecoder {
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom({ (decoder) -> Date in
            let container = try decoder.singleValueContainer()
            let dateStr = try container.decode(String.self)
            
            let dateFormatter = DateFormatter()
            dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            
            if let date = dateFormatter.date(from: dateStr) {
                return date
            } else {
                return Date.distantPast
            }
        })
        
        return decoder
    }
    
    func publish(request: URLRequest, decoder: JSONDecoder) -> AnyPublisher<T, APIError> {
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .mapError{ error in APIError.serverError(code: error.errorCode, message: error.localizedDescription) }
            .map { response in response.data }
            .decode(type: T.self, decoder: decoder)
            .mapError { _ in APIError.decodingError }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    
}
