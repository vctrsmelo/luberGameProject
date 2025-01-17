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
	private let TAXI_SPRITE_NAME: String = "Yellow_Taxi"
    private var backgroundMusic: SKAudioNode!
	public var highscoreLabel : SKLabelNode?
    private var pauseButton: SKSpriteNode!
    private var pauseScreen: SKSpriteNode!
    public var isPausedGame: Bool!
    private var explosion: SKSpriteNode!
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
        if !isPausedGame {
            luber.addPlayerSwipeRecognizer(to: self.view!)
        }
		addChild(luber.spriteNode)
        
        pauseScreen = childNode(withName: "pauseScreen") as! SKSpriteNode
        pauseButton = childNode(withName: "pauseButton") as! SKSpriteNode
        explosion = childNode(withName: "explosion") as! SKSpriteNode
        
        playAudios()
        
		if let lane1 = self.childNode(withName: "lane1"), let lane2 = self.childNode(withName: "lane2"), let lane3 = self.childNode(withName: "//lane3"){
			self.lane1 = lane1
			self.lane2 = lane2
			self.lane3 = lane3
		}
        Background.shared.distance = 0
		Background.shared.background = self.childNode(withName: "background") as? SKSpriteNode
		Background.shared.background2 = self.childNode(withName: "background2") as? SKSpriteNode
		Background.shared.kmLabel = self.childNode(withName: "kmLabel") as? SKLabelNode
		Background.shared.scene = self
		Background.shared.speed = -25
		
        if !hasGameOver {
            taxiGen = taxiGenerator(scene: self)
            timer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(self.generateTaxi), userInfo: nil, repeats: true)
        }
        
        //NotificationCenter.default.addObserver(self, selector: #selector(applicationWillResignActive), name: NSNotification.Name.UIApplicationWillResignActive, object: nil)
	}
    
    func applicationWillResignActive(notification: NSNotification) {
        if !self.isPausedGame {
            self.updatePause()
            
            DispatchQueue.global(qos: .background).async {
                
            }
        }
    }
    
    func setTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(self.generateTaxi), userInfo: nil, repeats: true)
    }
    
	override func update(_ currentTime: TimeInterval) {
		self.highscoreLabel = self.childNode(withName: "highscore") as? SKLabelNode
		distance = Background.shared.distance
		Background.shared.backgroundRoll()
		Background.shared.backgroundOutOfScreen()
	}
	
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        if !hasGameOver {
            if pauseButton.contains(touch.location(in: self)) {
                updatePause()
            }
        }
    }
    
    func updatePause() {
        isPausedGame = !isPausedGame
        
        if isPausedGame {
            pauseButton.run(SKAction.setTexture(SKTexture(imageNamed: "Icon_play")), withKey: "textureChange")
            pauseScreen.zPosition = 4
            
            luber.disablePlayerSwipeRecognizer(to: self.view!)
            timer.invalidate()

            Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.pauseGame), userInfo: nil, repeats: false)
        } else {
            pauseButton.run(SKAction.setTexture(SKTexture(imageNamed: "Icon_pause")), withKey: "textureChange")
            pauseScreen.zPosition = 0
            
            luber.addPlayerSwipeRecognizer(to: self.view!)
            timer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(self.generateTaxi), userInfo: nil, repeats: true)

            Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.unpauseGame), userInfo: nil, repeats: false)
        }
    }
    
    func pauseGame() {
        self.view?.isPaused = true
    }
    
    func unpauseGame() {
        self.view?.isPaused = false
        if taxis.count < 1 {
            generateTaxi()
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
            stopAnimations()
            backgroundMusic.run(SKAction.stop())
            animateCarCrash(at: contact.contactPoint)
            Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.endGameState), userInfo: nil, repeats: false)
		}
	}
	
	func endGameState(){
		
		let currentScore = Background.shared.distance 
		let userDefaults = UserDefaults.standard
		
        if let highscore = userDefaults.object(forKey: "highscore") as? Float {
            viewController.highscore = String(highscore)
            
            if(highscore < currentScore){
                userDefaults.set(currentScore, forKey: "highscore")
                userDefaults.synchronize()
                viewController.highscore = String(currentScore)
            }
        } else {
            userDefaults.set(currentScore, forKey: "highscore")
            userDefaults.synchronize()
            viewController.highscore = String(currentScore)
        }
        
		viewController.currentScore = String(currentScore)
		viewController.performSegue(withIdentifier: "endGame", sender: self)
	}
    
    func generateTaxi() {
        taxiGen?.trytoGenerate()
    }
    
    func removeTaxi(taxi:Taxi) {
        for i  in 0...taxis.count {
            if (taxi==taxis[i]) {
                taxis[i].spriteNode.removeFromParent()
                taxis.remove(at: i)
                break
            }
        }
    }
    
    func stopAnimations() {
        timer.invalidate()
        
        luber.spriteNode.removeAllActions()
        luber.disablePlayerSwipeRecognizer(to: self.view)
        
        Background.shared.speed = 0
        
        for taxi in taxis {
            taxi.spriteNode.removeAllActions()
        }
    }
    
    func playAudios(){
        let bg = SKAudioNode(fileNamed: "backgroundSong.m4a")
        bg.autoplayLooped = true
        addChild(bg)
        backgroundMusic = bg
    }
    
    func animateCarCrash(at contactPoint: CGPoint) {
        let textures = [SKTexture(imageNamed: "Explosion_01"), SKTexture(imageNamed: "Explosion_02"),
                        SKTexture(imageNamed: "Explosion_03"), SKTexture(imageNamed: "Explosion_04"),
                        SKTexture(imageNamed: "Explosion_05"), SKTexture(imageNamed: "Explosion_06"),
                        SKTexture(imageNamed: "Explosion_07")]
        let animate = SKAction.animate(with: textures, timePerFrame: 0.1)
        
        let playCrashAudio = SKAction.playSoundFileNamed("crash.m4a", waitForCompletion: true)
        let group = SKAction.group([animate, playCrashAudio])
        
        explosion.size = CGSize(width: 2 * textures[0].cgImage().width, height: 2 * textures[0].cgImage().height)
        explosion.run(SKAction.move(to: contactPoint, duration: 0))
        explosion.run(group)
    }
}


