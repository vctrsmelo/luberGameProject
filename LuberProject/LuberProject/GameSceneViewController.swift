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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
			var destination	= segue.destination as! EndGameViewController
			//Data has to be a variable name in your RandomViewController
		}
	}
	
}
