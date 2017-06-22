//
//  GameScene.swift
//  LuberProject
//
//  Created by Victor S Melo on 22/06/17.
//  Copyright © 2017 Victor S Melo. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameManagerScene: SKScene {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    private var luber: Luber!
    private var taxis: [Taxi] = []
    
    private let TAXI_SPRITE_NAME: String = "taxi"
    
    override func didMove(to view: SKView) {
        luber = Luber(spriteName: "Car01_test02", currentLane: 2)
        luber.addPlayerSwipeRecognizer(to: self.view!)
        addChild(luber.spriteNode)
		
		
		Background.shared.background = self.childNode(withName: "background") as? SKSpriteNode
		Background.shared.background2 = self.childNode(withName: "background2") as? SKSpriteNode
		Background.shared.scene = self
		Background.shared.speed = -15
		
    }
    
    override func update(_ currentTime: TimeInterval) {
		Background.shared.backgroundRoll()
		Background.shared.backgroundOutOfScreen()
		
    }
    
    func addTaxi(atLane lane: Int, carXDistance x: CGFloat, taxiSpeed: Float){
        
        var taxi = Taxi(spriteName: TAXI_SPRITE_NAME, currentLane: lane, speed: taxiSpeed)
        
    }
    
}
