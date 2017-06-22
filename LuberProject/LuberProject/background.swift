//
//  Background.swift
//  GameTest
//
//  Created by Cristiano Salla Lunardi on 6/22/17.
//  Copyright © 2017 Cristiano Salla Lunardi. All rights reserved.
//
import SpriteKit
import GameplayKit

class Background: NSObject {
	
	public var background : SKSpriteNode?
	public var background2 : SKSpriteNode?
	public var speed : Float?
	public var scene : SKScene?
	
	static let shared = Background()
	
	
	private override init() {
		
	}
	
	func backgroundOutOfScreen(){
		if(scene?.intersects(background!) == false){
			background?.position.y = (background2?.position.y)! + (background2?.size.height)!
		}
		
		
		if(scene?.intersects(background2!) == false ){
			background2?.position.y = (background?.position.y)! + (background?.size.height)!
		}
	}
	
	func setSpeed(speed : Float) -> Float {
		return speed
	}
	
	func backgroundRoll(){
		background?.run(SKAction.moveBy(x: 0, y: CGFloat(speed!), duration: 0))
		background2?.run(SKAction.moveBy(x: 0, y: CGFloat(speed!), duration: 0))
		
	}
	
}
