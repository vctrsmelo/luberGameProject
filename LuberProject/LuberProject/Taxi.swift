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
self.scene.removeTaxi(taxi: self)        }
        let sequence = SKAction.sequence([moveTaxi,removeTaxi])
        self.spriteNode.run(sequence, withKey: "taxiMove")
        
    }
}



//
//  GameScene.swift
//  LuberProject
//
//  Created by Victor S Melo on 22/06/17.
//  Copyright © 2017 Victor S Melo. All rights reserved.
//

//import SpriteKit
//import GameplayKit
//
//class GameManagerScene: SKScene {
//    var luber: Luber!
//    var taxis: [Taxi] = []
//    
//    private var lane1: SKNode!
//    private var lane2: SKNode!
//    private var lane3: SKNode!
//    var timer = Timer()
//    private var taxiGen : taxiGenerator?
//    private let TAXI_SPRITE_NAME: String = "Car01_test02"
//    
//    override func sceneDidLoad() {
//        if let lane1 = self.childNode(withName: "lane1"), let lane2 = self.childNode(withName: "lane2"), let lane3 = self.childNode(withName: "lane3"){
//            self.lane1 = lane1
//            self.lane2 = lane2
//            self.lane3 = lane3
//        }
//        
//        // TAXI TEST
//        taxiGen = taxiGenerator(scene: self)
//        timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.generateTaxi), userInfo: nil, repeats: true)
//        
//        // END TAXI TEST
//    }
//    
//    func generateTaxi(){
//        taxiGen?.trytoGenerate()
//    }
//    override func didMove(to view: SKView) {
//        luber = Luber(spriteName: "Car01_test02", currentLane: 2)
//        luber.addPlayerSwipeRecognizer(to: self.view!)
//        addChild(luber.spriteNode)
//        
//        Background.shared.background = self.childNode(withName: "background") as? SKSpriteNode
//        Background.shared.background2 = self.childNode(withName: "background2") as? SKSpriteNode
//        Background.shared.scene = self
//        Background.shared.speed = -15
//        
//        // TAXI TEST
//        
//        // END TAXI TEST
//    }
//    
//    override func update(_ currentTime: TimeInterval) {
//        Background.shared.backgroundRoll()
//        Background.shared.backgroundOutOfScreen()
//        
//        if hasColision() {
//            luber.spriteNode.removeAction(forKey: "moveToLeft")
//            luber.spriteNode.removeAction(forKey: "moveToRight")
//            Background.shared.speed = 0
//            
//            for taxi in taxis {
//                taxi.spriteNode.removeAction(forKey: "taxiTest")
//            }
//        }
//    }
//    func removeTaxi(taxi:Taxi){
//        for i  in 0...taxis.count{
//            if (taxi==taxis[i]){taxis.remove(at: i)
//                break}
//        }
//        
//    }
//    
//    func addTaxi(atLane lane: Int, carYDistance yCars: CGFloat, taxiSpeed: Float){
//        let taxi = Taxi(spriteName: TAXI_SPRITE_NAME, currentLane: lane, speed: taxiSpeed,scene: self)
//        let taxiHeight = taxi.spriteNode.frame.size.height
//        
//        var laneX = lane1.frame.origin.x
//        if(lane == 2){
//            laneX = lane2.frame.origin.x
//        }else if(lane == 3){
//            laneX = lane3.frame.origin.x
//        }
//        
//        taxi.spriteNode.position = CGPoint(x: laneX, y: self.frame.size.height/2+taxiHeight/2+taxiHeight*yCars)
//        taxi.spriteNode.color = SKColor.red
//        self.taxis.append(taxi)
//        self.addChild(taxi.spriteNode)
//    }
//    
//    func hasColision() -> Bool {
//        let x = luber.spriteNode.position.x
//        let y = luber.spriteNode.position.y
//        
//        for taxi in taxis {
//            if x > (taxi.spriteNode.position.x - taxi.spriteNode.size.width) && x < (taxi.spriteNode.position.x + taxi.spriteNode.size.width) {
//                if y > (taxi.spriteNode.position.y - taxi.spriteNode.size.height) && y < (taxi.spriteNode.position.y + taxi.spriteNode.size.height) {
//                    print("\nCOLIDIU\n")
//                    return true
//                }
//            }
//        }
//        
//        return false
//    }
//}
