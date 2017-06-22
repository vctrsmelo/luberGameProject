//
//  Car.swift
//  LuberProject
//
//  Created by Victor S Melo on 22/06/17.
//  Copyright © 2017 Victor S Melo. All rights reserved.
//

import Foundation
import SpriteKit

enum Lane {
    case one
    case two
    case three
}

class Car {
    
    var spriteNode: SKSpriteNode
    var currentLane: Lane
    
    init(spriteName: String, currentLane: Lane) {

        let spriteNode = SKSpriteNode(fileNamed: spriteName)
        if spriteNode == nil {
            
            print("[ERROR] Car.swift - init: spriteNode is nil. Possibly the filename is wrong")
            
        }
        
        self.spriteNode = spriteNode!
        self.currentLane = currentLane

    }
}
