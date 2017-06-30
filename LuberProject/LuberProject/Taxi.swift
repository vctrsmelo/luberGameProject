//
//  Taxi.swift
//  LuberProject
//
//  Created by Victor S Melo on 22/06/17.
//  Copyright © 2017 Victor S Melo. All rights reserved.
//

import Foundation
import SpriteKit
class Taxi: Car{
    
    var speed: Double
    var scene: GameManagerScene
    init(spriteName: String, currentLane: Int, speed: Float,scene : GameManagerScene) {
        self.speed = Double(speed)
        self.scene = scene

        super.init(spriteName: spriteName, currentLane: currentLane)
        goDown()
    }
    
    func goDown() {
        
        let moveTaxi = SKAction.move(by: CGVector(dx: 0, dy: -2750), duration: speed)
        let removeTaxi = SKAction.run {
            self.scene.removeTaxi(taxi: self)
        }
        let sequence = SKAction.sequence([moveTaxi,removeTaxi])
        self.spriteNode.run(sequence, withKey: "taxiMovement")
        
    }
}
