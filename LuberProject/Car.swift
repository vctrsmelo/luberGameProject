//
//  Car.swift
//  LuberProject
//
//  Created by Victor S Melo on 22/06/17.
//  Copyright © 2017 Victor S Melo. All rights reserved.
//

import Foundation
import SpriteKit

class Car {
    
    var spriteNode: SKSpriteNode
    var currentLane: Int
    
    private var size = CGSize(width: 200, height: 400)
    
    let laneSize = 200
    let changeLaneSpeed = 0.2
    
    init(spriteName: String, currentLane: Int) {

        let spriteNode = SKSpriteNode()

//        let texture = SKTexture(imageNamed: spriteName)
//        if texture == nil {
//            print("[ERROR] Car.swift - init: spriteNode is nil. Possibly the filename is wrong")
//        }
//        
//        spriteNode.texture = texture

        self.spriteNode = spriteNode
        self.currentLane = currentLane
		self.spriteNode.position.y = CGFloat(-400)
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
