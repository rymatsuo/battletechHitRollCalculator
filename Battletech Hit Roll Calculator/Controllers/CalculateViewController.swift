//
//  CalculateViewController.swift
//  Battletech Hit Roll Calculator
//
//  Created by User on 6/3/20.
//  Copyright © 2020 Ryan Matsuo. All rights reserved.
//

import UIKit

class CalculateViewController: UIViewController {
    
    var toHitNumber = 5
    @IBOutlet weak var commentaryTextLabel: UILabel!
    @IBOutlet weak var aquireNextTargetLabel: UIButton!
    
    var autoHitPhrases = "Not even going to\nbreak a sweat"
    var easyShotPhrases = "This is going to be easy"
    var mediumShotPhrases = "I'd say 50/50 on the target"
    var difficultShotPhrases = "Good thing I brought\n along the extra ammo"
    var impossibleShotPhrase = "Are you kidding me even\n Kerensky couldn't\nmake this shot"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set up font and text sizes for labels
        commentaryTextLabel.font = UIFont(name: "HMType", size: 20.0)
        toHitNumberImage.font = UIFont(name: "HMType", size: 70.0)
        toHitNumberImage.text = "\(toHitNumber)"
        aquireNextTargetLabel.titleLabel?.font = UIFont(name: "HMType", size: 20.0)
        
        //Set up auto hit and auto miss results
        if toHitNumber <= 2 {
            toHitNumberImage.text = "Auto\nHit"
        } else if toHitNumber > 12 {
            toHitNumberImage.text = "Auto\nMiss"
        }
        
        switch toHitNumber {
        case 0...2:
            commentaryTextLabel.text = autoHitPhrases
        case 3...5:
            commentaryTextLabel.text = easyShotPhrases
        case 6...8:
            commentaryTextLabel.text = mediumShotPhrases
        case 9...12:
            commentaryTextLabel.text = difficultShotPhrases
        default:
            commentaryTextLabel.text = impossibleShotPhrase
        }
        

    }
    @IBOutlet weak var toHitNumberImage: UILabel!
    
    @IBAction func nextTargetButtonPressed(_ sender: UIButton) { dismiss(animated: true, completion: nil)
    }
}
