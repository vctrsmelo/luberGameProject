//
//  MainMenuManager.swift
//  LuberProject
//
//  Created by Cristiano Salla Lunardi on 6/26/17.
//  Copyright © 2017 Victor S Melo. All rights reserved.
//

import SpriteKit

class MainMenuManager: SKScene {
	
	public var viewController: MainMenuViewController!
	private var taxis: [SKSpriteNode] = []
    private var playButton: SKSpriteNode!
	
	override func didMove(to view: SKView) {
		
		taxis.append(self.childNode(withName: "taxi1") as! SKSpriteNode)
		taxis.append(self.childNode(withName: "taxi2") as! SKSpriteNode)
		taxis.append(self.childNode(withName: "taxi3") as! SKSpriteNode)
		
		for taxi in taxis{
			let random = Int((arc4random_uniform(10))+1)
			taxi.position.y = CGFloat(-1000*random)
		}
        
        playButton = childNode(withName: "StartGame") as! SKSpriteNode
        let increaseScale = SKAction.scale(by: 1.1, duration: 0.5)
        let decreaseScale = SKAction.scale(to: 1, duration: 0.5)
        let animation = SKAction.repeatForever(SKAction.sequence([increaseScale, decreaseScale]))
        playButton.run(animation)
	}
	
	override func update(_ currentTime: TimeInterval) {
		carOutOfScreen()
		taxiRoll()
	}
	
	func carOutOfScreen(){
		for taxi in taxis{
			if((Int((taxi.position.y)) > 0) && ((scene?.intersects(taxi))! == false)){
				let random = Int((arc4random_uniform(10))+1)
				taxi.position.y = CGFloat(-1000*random)
			}
		}
	}
	
	func taxiRoll(){
		for taxi in taxis{
			taxi.run(SKAction.moveBy(x: 0, y: 35, duration: 0))
		}
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		
		let touch = touches.first!
		let viewTouchLocation = touch.location(in: self.view)
		let sceneTouchPoint = scene? .convertPoint(fromView: viewTouchLocation)
		let touchedNode = scene?.atPoint(sceneTouchPoint!)
		
		if (touchedNode?.name == "StartGame") {
			viewController.performSegue(withIdentifier: "gotoGame", sender: nil)
		}
	}
}
