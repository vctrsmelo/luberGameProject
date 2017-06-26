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
	
    override func viewDidLoad() {
        super.viewDidLoad()
    }
	
	var skview : SKView!
	
	override func viewDidAppear(_ animated: Bool) {
	
		let scene = SKScene.init(fileNamed: "GameManagerScene") as! GameManagerScene
		skview = self.view as! SKView
		
	
		scene.scaleMode = SKSceneScaleMode.aspectFit
		
		scene.viewController = self
		skview.presentScene(scene)
		
		
	
	}
	
	override func viewDidDisappear(_ animated: Bool) {
		skview.presentScene(nil)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "endGame"{
			let destination	= segue.destination as! EndGameViewController
			destination.currentScoreString = currentScore
			destination.highscoreString = highscore
			
		}
	}
	
	
	@IBAction func unwind(segue:UIStoryboardSegue) {
		
		
	}
	
}
