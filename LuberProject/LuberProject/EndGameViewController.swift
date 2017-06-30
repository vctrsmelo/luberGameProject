//
//  EndGameViewController.swift
//  LuberProject
//
//  Created by Cristiano Salla Lunardi on 6/23/17.
//  Copyright © 2017 Victor S Melo. All rights reserved.
//

import UIKit

class EndGameViewController: UIViewController, UIGestureRecognizerDelegate {

	@IBOutlet weak var highscore: UILabel!
	@IBOutlet weak var currentScore: UILabel!
	@IBOutlet weak var creditsLabel: UILabel!
	
	public var currentScoreString : String = ""
	public var highscoreString : String = ""
    public var currentScoreNumber: Double = 0.0
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		currentScore.text = currentScoreString
		highscore.text = highscoreString
        
        GameAnalytics.addDesignEvent(withEventId: "UserScore", value: currentScoreNumber as NSNumber)
		
		creditsLabel.isUserInteractionEnabled = true
		
		let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector (self.handleTap(gestureRecognizer:)))
		
		creditsLabel.addGestureRecognizer(gestureRecognizer)
    }
	
	func handleTap(gestureRecognizer: UIGestureRecognizer){
		performSegue(withIdentifier: "gotoCredits", sender: nil)
	}
	
	@IBAction func unwind(segue:UIStoryboardSegue) {
		
		
	}
	
	
	override var prefersStatusBarHidden: Bool {
		return true
	}
}
