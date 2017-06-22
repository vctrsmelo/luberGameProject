//
//  Taxi.swift
//  LuberProject
//
//  Created by Victor S Melo on 22/06/17.
//  Copyright © 2017 Victor S Melo. All rights reserved.
//

import Foundation

class Taxi: Car{
    
    var speed: Float
    
    init(spriteName: String, currentLane: Int, speed: Float) {
        self.speed = speed
        super.init(spriteName: spriteName, currentLane: currentLane)
    }
}
