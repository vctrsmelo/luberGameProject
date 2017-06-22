//
//  Car.swift
//  LuberProject
//
//  Created by Victor S Melo on 22/06/17.
//  Copyright © 2017 Victor S Melo. All rights reserved.
//

import Foundation
import SpriteKit

class Car: NSObject {
    
    var spriteNode: SKSpriteNode
    var currentLane: Int
    
    let laneSize = 200
    let changeLaneSpeed = 0.2
    
    init(spriteName: String, currentLane: Int) {

        let spriteNode = SKSpriteNode(fileNamed: spriteName)
        if spriteNode == nil {
            print("[ERROR] Car.swift - init: spriteNode is nil. Possibly the filename is wrong")
        }
        
        self.spriteNode = spriteNode!
        self.currentLane = currentLane
    }
    
    func moveToLeft() {
        if currentLane > 1 {
            currentLane -= 1
            
            let move = SKAction.move(by: CGVector(dx: -laneSize, dy: 0),
                                     duration: changeLaneSpeed)
            let rotateLeft = SKAction.rotate(byAngle: CGFloat(GLKMathDegreesToRadians(30.0)),
                                             duration: changeLaneSpeed/2)
            let rotateRight = SKAction.rotate(byAngle: CGFloat(GLKMathDegreesToRadians(-30.0)),
                                              duration: changeLaneSpeed/2)
            
            let group = SKAction.group([move, rotateLeft])
            let sequence = SKAction.sequence([group, rotateRight])
            
            spriteNode.run(sequence, withKey: "moveToLeft")
        }
    }
    
    func moveToRight() {
        if currentLane < 3 {
            currentLane += 1
            
            let move = SKAction.move(by: CGVector(dx: laneSize, dy: 0), duration: changeLaneSpeed)
            let rotateRight = SKAction.rotate(byAngle: CGFloat(GLKMathDegreesToRadians(-30.0)),
                                              duration: changeLaneSpeed/2)
            let rotateLeft = SKAction.rotate(byAngle: CGFloat(GLKMathDegreesToRadians(30.0)),
                                             duration: changeLaneSpeed/2)
            
            let group = SKAction.group([move, rotateRight])
            let sequence = SKAction.sequence([group, rotateLeft])
            
            spriteNode.run(sequence, withKey: "moveToRight")
        }
    }

}
