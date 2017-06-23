//
//  Luber.swift
//  LuberProject
//
//  Created by Victor S Melo on 22/06/17.
//  Copyright © 2017 Victor S Melo. All rights reserved.
//

import Foundation
import SpriteKit

class Luber: Car {
    
    func addPlayerSwipeRecognizer(to view: SKView!) {
        let swipeLeft = UISwipeGestureRecognizer()
        swipeLeft.direction = .left
        swipeLeft.addTarget(self, action: #selector(moveToLeft))
        view!.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer()
        swipeRight.direction = .right
        swipeRight.addTarget(self, action: #selector(moveToRight))
        view!.addGestureRecognizer(swipeRight)
    }
    
    func disablePlayerSwipeRecognizer(to view: SKView!) {
        for gestureRecognizer in view!.gestureRecognizers! {
            if let g: UIGestureRecognizer = gestureRecognizer as UIGestureRecognizer! {
                g.isEnabled = false
            }
        }
    }
}
