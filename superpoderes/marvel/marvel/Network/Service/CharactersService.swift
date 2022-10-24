//
//  CharactersService.swift
//  marvel
//
//  Created by Victoria Aloy on 21/10/22.
//

import Foundation
import Combine

class CharactersService: BaseService<ResponseApi<CharacterApi>>{
    
    func execute(characterId: String? = nil, searchTerm: String? = nil, page: Int = 0,
                 limit: Int = 20) -> AnyPublisher<ResponseApi<CharacterApi>, APIError> {
        var endPoint = Endpoints.characters
        var pageParams = ""
        let pageNumber = (page < 0 ? 0 : page)
        let offset = limit * pageNumber
        if let _ = characterId {
            endPoint = endPoint + "/\(characterId!)"
        } else {
            pageParams = "&limit=\(limit)&offset=\(offset)"
        }
        if let name = searchTerm, name.count > 0 {
            pageParams = "&nameStartsWith=\(name)"
        }
        let urlString = "\(endPoint)?apikey=\(Secret.publicKey)&hash=\(Secret.md5)&ts=\(Secret.ts)\(pageParams)"
        
        if let url = URL(string: urlString){
            
            return buildRequest(url: url, httpMethod: HttpMethod.get)
        }
        
        return Fail(error:APIError.urlError).eraseToAnyPublisher()
    }
}
