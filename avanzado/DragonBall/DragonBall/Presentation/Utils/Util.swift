//
//  Util.swift
//  DragonBall
//
//  Created by Victoria Aloy on 20/9/22.
//

import Foundation

func toUrl(str: String?)->URL?{
    if str == nil {
        return nil
    }
    
    return URL(string: str!)
        
}
