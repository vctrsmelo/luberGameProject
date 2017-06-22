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
    var taxis: [Taxi] = []

    private var lane1: SKNode!
    private var lane2: SKNode!
    private var lane3: SKNode!
    
    private let TAXI_SPRITE_NAME: String = "spaceship"
    
    override func sceneDidLoad() {

        if let lane1 = self.childNode(withName: "lane1"), let lane2 = self.childNode(withName: "lane2"), let lane3 = self.childNode(withName: "//lane3"){
            self.lane1 = lane1
            self.lane2 = lane2
            self.lane3 = lane3
        }
        
        addTaxi(atLane: 3, carYDistance: 0, taxiSpeed: 1)
        
        
    }
    
    override func didMove(to view: SKView) {
        luber = Luber(spriteName: "Car01_test", currentLane: 2)
        luber.addPlayerSwipeRecognizer(to: self.view!)
        addChild(luber.spriteNode)
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    func addTaxi(atLane lane: Int, carYDistance yCars: CGFloat, taxiSpeed: Float){
        
        var taxi = Taxi(spriteName: TAXI_SPRITE_NAME, currentLane: lane, speed: taxiSpeed)
        
        var taxiHeight = taxi.spriteNode.frame.size.height
        
        var laneX = lane1.frame.origin.x
        
        if(lane == 2){
            
            laneX = lane2.frame.origin.x
            
        }else if(lane == 3){
            
            laneX = lane3.frame.origin.x
            
        }
        
        taxi.spriteNode.position = CGPoint(x: laneX, y: self.frame.size.height/2+taxiHeight/2+taxiHeight*yCars)
        taxi.spriteNode.color = SKColor.red
        self.taxis.append(taxi)
        self.addChild(taxi.spriteNode)
        
    }
    
}
