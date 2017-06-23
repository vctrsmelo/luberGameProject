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
    var isMoving: Bool = false
    
    private var size = CGSize(width: 200, height: 400)
    
    let laneSize = 189
    let changeLaneSpeed = 0.2
    
    init(spriteName: String, currentLane: Int) {
        self.spriteNode = SKSpriteNode(imageNamed: spriteName)
        self.currentLane = currentLane
		self.spriteNode.position.y = CGFloat(-400)
    }
    
    func moveToLeft() {
        if !isMoving {
            isMoving = true
            
            if currentLane > 1 {
                currentLane -= 1
                
                let move = SKAction.move(by: CGVector(dx: -laneSize, dy: 0),
                                         duration: changeLaneSpeed)
                let rotate = SKAction.rotate(byAngle: CGFloat(GLKMathDegreesToRadians(30.0)),
                                             duration: changeLaneSpeed/2)
                let rotateBack = SKAction.rotate(toAngle: CGFloat(GLKMathDegreesToRadians(0.0)),
                                                 duration: changeLaneSpeed/2)
                
                let group = SKAction.group([move, rotate])
                let sequence = SKAction.sequence([group, rotateBack])
                
                spriteNode.run(sequence, withKey: "moveToLeft")
            }
            isMoving = false
        }
    }
    
    func moveToRight() {
        if !isMoving {
            isMoving = true
            
            if currentLane < 3 {
                currentLane += 1
                
                let move = SKAction.move(by: CGVector(dx: laneSize, dy: 0), duration: changeLaneSpeed)
                let rotate = SKAction.rotate(byAngle: CGFloat(GLKMathDegreesToRadians(-30.0)),
                                             duration: changeLaneSpeed/2)
                let rotateBack = SKAction.rotate(toAngle: CGFloat(GLKMathDegreesToRadians(0.0)),
                                                 duration: changeLaneSpeed/2)
                
                let group = SKAction.group([move, rotate])
                let sequence = SKAction.sequence([group, rotateBack])
                
                spriteNode.run(sequence, withKey: "moveToRight")
            }
            isMoving = false
        }
    }

}
