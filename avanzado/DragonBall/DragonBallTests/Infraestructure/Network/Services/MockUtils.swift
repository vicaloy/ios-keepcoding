//
//  MockUtils.swift
//  DragonBallTests
//
//  Created by Victoria Aloy on 25/9/22.
//

import Foundation
import XCTest
@testable import DragonBall

class MockUtils {
    static func getDataFromJson(test: AnyClass, resourceName: String) -> Data? {
        let bundle = Bundle(for: test.self)
        
        guard let path = bundle.path(forResource: resourceName, ofType: "json") else {
            return nil
        }
        
        return try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
    }
}
