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
		let conx = (spriteNode.texture?.size().height)! - 40
		let cony = (spriteNode.texture?.size().width)! - 40
		let size = CGSize.init(width: cony, height: conx)
		self.spriteNode.physicsBody = SKPhysicsBody.init(rectangleOf: size)
		self.spriteNode.physicsBody?.affectedByGravity = false
		self.spriteNode.physicsBody?.contactTestBitMask = 0x00000001
	}
    
    func moveToLeft() {
        
        if !isMoving {
            isMoving = true
            
            if currentLane > 1 {
                currentLane -= 1
                
                let move = SKAction.move(to: CGPoint(x: (currentLane - 2) * laneSize, y: Int(spriteNode.position.y)),
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
                
                let move = SKAction.move(to: CGPoint(x: (currentLane - 2) * laneSize, y: Int(spriteNode.position.y)),
                                         duration: changeLaneSpeed)
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
