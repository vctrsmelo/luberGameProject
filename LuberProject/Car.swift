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
    case 1,
    case 2,
    case 3
}

class Car {
    
    var spriteNode: SKSpriteNode
    var currentLane: Lane
    
    init(spriteName: String, currentLane: Lane) {
        self.spriteNode = SKSpriteNode(fileNamed: spriteName)
        self.currentLane = currentLane
    }
}
