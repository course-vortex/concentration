//
//  Ball.swift
//  concentration
//
//  Created by Olha Dzhyhirei on 2/14/23.
//

import Foundation

struct Ball {
    var isShowing = false
    var isMathced = false
    var identifier: Int
    
    static var identifierFactory = 0
    
    static func getUnicIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Ball.getUnicIdentifier()
    }
}

