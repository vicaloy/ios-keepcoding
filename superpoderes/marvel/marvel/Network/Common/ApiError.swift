

import Foundation

public enum APIError: Error, Equatable {
    
    public static func == (lhs: APIError, rhs: APIError) -> Bool {
        switch(lhs, rhs){
        case(.urlError, .urlError):
            return true
        case (.internalError, .internalError):
            return true
        case (.decodingError, .decodingError):
            return true
        default:
            return false
            
        }
    }
    
    case urlError
    case internalError
    case decodingError
    case serverError(code: Int, message: String)
}
