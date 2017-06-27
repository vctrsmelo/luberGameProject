//
//  GameSceneViewController.swift
//  LuberProject
//
//  Created by Cristiano Salla Lunardi on 6/23/17.
//  Copyright © 2017 Victor S Melo. All rights reserved.
//

import UIKit
import SpriteKit

class GameSceneViewController: UIViewController {

	public var highscore : String!
	public var currentScore : String!
    var skview : SKView!
    var gamescene : GameManagerScene?
	
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.pause), name:NSNotification.Name.UIApplicationDidEnterBackground, object: nil)
        
         NotificationCenter.default.addObserver(self, selector: #selector(self.unpause), name:NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
    }
	
	override func viewDidAppear(_ animated: Bool) {
	
		let scene = SKScene.init(fileNamed: "GameManagerScene") as! GameManagerScene
		skview = self.view as! SKView
		gamescene = scene
	
		scene.scaleMode = SKSceneScaleMode.aspectFit
		
		scene.viewController = self
		skview.presentScene(scene)
	}
    
	override var prefersStatusBarHidden: Bool {
		return true
	}
	
    func pause(){
        let isPausedGame: Bool! = gamescene?.isPausedGame
        if isPausedGame {
            gamescene?.timer.invalidate()
        }
    }
    
    func unpause(){
        let isPausedGame: Bool! = gamescene?.isPausedGame
        if !isPausedGame {
            gamescene?.setTimer()
        }
    }
    
	override func viewDidDisappear(_ animated: Bool) {
		skview.presentScene(nil)
	}
    
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "endGame"{
			let destination	= segue.destination as! EndGameViewController
			destination.currentScoreString = currentScore + " Km"
			destination.highscoreString = highscore + " Km"
			
		}
	}
    
    @IBAction func unwind(segue:UIStoryboardSegue) {
        
        
    } 
}
