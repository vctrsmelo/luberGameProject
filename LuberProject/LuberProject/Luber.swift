//
//  Luber.swift
//  LuberProject
//
//  Created by Victor S Melo on 22/06/17.
//  Copyright © 2017 Victor S Melo. All rights reserved.
//

import Foundation
import SpriteKit

class Luber: Car{
    
    override init(spriteName: String, currentLane: Int) {
        super.init(spriteName: spriteName, currentLane: currentLane)
    }
    
    func addPlayerSwipeRecognizer(to view: SKView!) {
        let swipeLeft = UISwipeGestureRecognizer()
        swipeLeft.direction = .left
        swipeLeft.addTarget(self, action: Selector("moveToLeft"))
        view!.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer()
        swipeRight.direction = .right
        swipeRight.addTarget(self, action: Selector("moveToRight"))
        view!.addGestureRecognizer(swipeRight)
    }
}
