//
//  EndGameViewController.swift
//  LuberProject
//
//  Created by Cristiano Salla Lunardi on 6/23/17.
//  Copyright © 2017 Victor S Melo. All rights reserved.
//

import UIKit

class EndGameViewController: UIViewController {

	@IBOutlet weak var highscore: UILabel!
	@IBOutlet weak var currentScore: UILabel!
	
	public var currentScoreString : String = ""
	public var highscoreString : String = ""
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		currentScore.text = currentScoreString
		highscore.text = highscoreString
		
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
