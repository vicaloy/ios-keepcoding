//
//  JsonData.swift
//  DragonBallTests
//
//  Created by Victoria Aloy on 24/7/22.
//

import Foundation

func getJsonData(bundle: Bundle, resourceName: String) -> Data? {
    
    guard let path = bundle.path(forResource: resourceName, ofType: "json") else {
        return nil
    }
    
    return try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
}
