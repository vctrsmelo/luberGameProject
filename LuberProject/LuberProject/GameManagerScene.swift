//
//  GameScene.swift
//  LuberProject
//
//  Created by Victor S Melo on 22/06/17.
//  Copyright © 2017 Victor S Melo. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameManagerScene: SKScene, SKPhysicsContactDelegate{
	var luber: Luber!
	var taxis: [Taxi] = []
    var timer = Timer()
    var distance : Float = 0
	public var viewController : GameSceneViewController!
    private var taxiGen : taxiGenerator?
	private var lane1: SKNode!
	private var lane2: SKNode!
	private var lane3: SKNode!
	private let TAXI_SPRITE_NAME: String = "Taxi_test01"
    private var backgroundMusic: SKAudioNode!
	public var highscoreLabel : SKLabelNode?
    private var pauseButton: SKSpriteNode!
    private var isPausedGame: Bool!
	private var hasGameOver: Bool!
	
	override func sceneDidLoad() {
		if let lane1 = self.childNode(withName: "lane1"), let lane2 = self.childNode(withName: "lane2"), let lane3 = self.childNode(withName: "lane3"){
			self.lane1 = lane1
			self.lane2 = lane2
			self.lane3 = lane3
		}
        
        isPausedGame = false
        hasGameOver = false
	}
	
	override func didMove(to view: SKView) {
		physicsWorld.contactDelegate = self
		
		luber = Luber(spriteName: "Car01_test02", currentLane: 2)
		luber.addPlayerSwipeRecognizer(to: self.view!)
		addChild(luber.spriteNode)
        
        pauseButton = childNode(withName: "pauseButton") as! SKSpriteNode
		

        playAudios()
        
		if let lane1 = self.childNode(withName: "lane1"), let lane2 = self.childNode(withName: "lane2"), let lane3 = self.childNode(withName: "//lane3"){
			self.lane1 = lane1
			self.lane2 = lane2
			self.lane3 = lane3
		}

		Background.shared.background = self.childNode(withName: "background") as? SKSpriteNode
		Background.shared.background2 = self.childNode(withName: "background2") as? SKSpriteNode
		Background.shared.kmLabel = self.childNode(withName: "kmLabel") as? SKLabelNode
		Background.shared.scene = self
		Background.shared.speed = -25
		
        if !hasGameOver {
            taxiGen = taxiGenerator(scene: self)
            timer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(self.generateTaxi), userInfo: nil, repeats: true)
        }
	}
	
	override func update(_ currentTime: TimeInterval) {
		self.highscoreLabel = self.childNode(withName: "highscore") as? SKLabelNode
		distance = Background.shared.distance
		Background.shared.backgroundRoll()
		Background.shared.backgroundOutOfScreen()
	}
	
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        if pauseButton.contains(touch.location(in: self)) {
            updatePause()
        }
    }
    
    func updatePause() {
        isPausedGame = !isPausedGame
        
        if isPausedGame {
            timer.invalidate()
            self.view?.isPaused = true
        } else {
            timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.generateTaxi), userInfo: nil, repeats: true)
            self.view?.isPaused = false
        }
    }
    
	func addTaxi(atLane lane: Int, carYDistance yCars: CGFloat, taxiSpeed: Float){
		let taxi = Taxi(spriteName: TAXI_SPRITE_NAME, currentLane: lane, speed: taxiSpeed, scene: self)
		let taxiHeight = taxi.spriteNode.frame.size.height
		
		var laneX = lane1.frame.origin.x
		if(lane == 2){
			laneX = lane2.frame.origin.x
		}else if(lane == 3){
			laneX = lane3.frame.origin.x
		}
		
		taxi.spriteNode.position = CGPoint(x: laneX, y: self.frame.size.height/2+taxiHeight/2+taxiHeight*yCars)
		self.taxis.append(taxi)
		self.addChild(taxi.spriteNode)
	}
	
	func didBegin(_ contact: SKPhysicsContact) {
	
		if(contact.bodyA.node == luber.spriteNode || contact.bodyB.node == luber.spriteNode){
            hasGameOver = true
            taxiGen?.maxNumberOfTaxi = 0
            
			luber.spriteNode.removeAction(forKey: "moveToLeft")
			luber.spriteNode.removeAction(forKey: "moveToRight")
			Background.shared.speed = 0
			
			for taxi in taxis {
				taxi.spriteNode.removeAction(forKey: "taxiMovement")
			}

            
            backgroundMusic.run(SKAction.stop())
			playCrashAudio()
			endGameState()
            
		}
	}
	
	func endGameState(){
		
		let currentScore = Background.shared.distance 
		let userDefaults = UserDefaults.standard
		
		let highscore = userDefaults.object(forKey: "highscore") as? Float
		
		viewController.highscore = String(highscore!)
		
		if(highscore! < currentScore){
			userDefaults.set(currentScore, forKey: "highscore")
			userDefaults.synchronize()
			viewController.highscore = String(currentScore)
			
		}
		
		viewController.currentScore = String(currentScore)
		viewController.performSegue(withIdentifier: "endGame", sender: self)
		
	}
    func generateTaxi(){
        taxiGen?.trytoGenerate()
    }
    func removeTaxi(taxi:Taxi){
        for i  in 0...taxis.count{
            if (taxi==taxis[i]){taxis[i].spriteNode.removeFromParent()
                taxis.remove(at: i)
                
                break}
        }
	
    }
    
    func playAudios(){
        
        let bg = SKAudioNode(fileNamed: "backgroundSong.m4a")
        bg.autoplayLooped = true
        addChild(bg)
        backgroundMusic = bg
        
    }
    
    func playCrashAudio(){
        
        self.run(SKAction.playSoundFileNamed("crash.m4a", waitForCompletion: true))
        
    }
}


