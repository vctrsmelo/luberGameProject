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
	public var kmLabel : SKLabelNode?
	public var speed : Float
	public var scene : SKScene?
	var coeficientIncrementSpeed : Float
	var coeficientDeltaDistance : Float
	var distance : Float
	var deltaDistance : Float
	var speedLimit : Float
	
	static let shared = Background()
	
	
	private override init() {
        self.speed = 0
		self.coeficientIncrementSpeed = 1
		self.coeficientDeltaDistance = 0.3
		self.distance = 0.0
		self.deltaDistance = 0.0
		self.speedLimit = 35.0
	}
	
	func backgroundOutOfScreen(){
		if((Int((background?.position.y)!) < 0) && ((scene?.intersects(background!))! == false)){
			incrementSpeedAndDistance()
			background?.position.y = (background2?.position.y)! + (background2?.size.height)!
		}
		
		if((Int((background2?.position.y)!) < 0) && scene?.intersects(background2!) == false){
			incrementSpeedAndDistance()
			background2?.position.y = (background?.position.y)! + (background?.size.height)!
		}
		
	}
	
	func incrementSpeedAndDistance(){
		if(deltaDistance == self.coeficientDeltaDistance && self.speed > -self.speedLimit){
			self.speed = self.speed - self.coeficientIncrementSpeed
            deltaDistance = 0
		}
        
		self.distance = self.distance + 0.1
		self.deltaDistance = self.deltaDistance + 0.1
		kmLabel?.text = String(format: "%.1f", self.distance)
        
        print("Speed \(speed)\n")
	}
	
	func backgroundRoll(){
		background?.run(SKAction.moveBy(x: 0, y: CGFloat(speed), duration: 0))
		background2?.run(SKAction.moveBy(x: 0, y: CGFloat(speed), duration: 0))
		
	}
	
}
