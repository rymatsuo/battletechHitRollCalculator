//
//  OtherModifiersViewController.swift
//  Battletech Hit Roll Calculator
//
//  Created by User on 6/3/20.
//  Copyright © 2020 Ryan Matsuo. All rights reserved.
//

import UIKit

class OtherModifiersViewController: UIViewController {

    @IBOutlet weak var otherModifiersTitleLabel: UILabel!
    @IBOutlet weak var mechDamageModifierLabel: UILabel!
    @IBOutlet weak var multipleTargetLabel: UILabel!
    @IBOutlet weak var specializedAttackLabel: UILabel!
    @IBOutlet weak var doneButtonLabel: UIButton!
    @IBOutlet weak var upperArmSwitchOutlet: UISwitch!
    @IBOutlet weak var lowerArmSwitchOutlet: UISwitch!
    
    //Other modifiers value initilization
    var sensorHit = 0
    var shoulderHit = 0
    var upperArmHit = 0
    var lowerArmHit = 0
    var secondaryTargetFwd = 0
    var secondaryTargetRearSide = 0
    var indirectFire = 0
    var spotting = 0
    var totalOtherModifiers = 0
    
    var otherModifiersDelegate: otherModifiersSelectionDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        otherModifiersTitleLabel.font = UIFont(name: "HMType", size: 20.0)
        mechDamageModifierLabel.font = UIFont(name: "HMType", size: 20.0)
        multipleTargetLabel.font = UIFont(name: "HMType", size: 20.0)
        specializedAttackLabel.font = UIFont(name: "HMType", size: 20.0)
        doneButtonLabel.titleLabel?.font = UIFont(name: "HMType", size: 20.0)
    }
    
    @IBAction func sensorHitSwitched(_ sender: UISwitch) {
        if sender.isOn == true {
            sensorHit = 2
        } else {
            sensorHit = 0
        }
    }
    @IBAction func shoulderHitButtonSwitched(_ sender: UISwitch) {
        if sender.isOn == true {
            shoulderHit = 4
            upperArmSwitchOutlet.isEnabled = false
            upperArmSwitchOutlet.isOn = false
            lowerArmSwitchOutlet.isEnabled = false
            lowerArmSwitchOutlet.isOn = false
        } else {
            shoulderHit = 0
            upperArmSwitchOutlet.isEnabled = true
            lowerArmSwitchOutlet.isEnabled = true
        }
    }
    @IBAction func upperArmButtonSwitched(_ sender: UISwitch) {
        if sender.isOn == true {
            upperArmHit = 1
        } else {
            upperArmHit = 0
        }
        
    }
    @IBAction func lowerArmButtonSwitched(_ sender: UISwitch) {
        if sender.isOn == true {
            lowerArmHit = 1
        } else {
            lowerArmHit = 0
        }
    }
    
    @IBAction func targetFwdArcSwitched(_ sender: UISwitch) {
        if sender.isOn == true {
            secondaryTargetFwd = 1
        } else {
            secondaryTargetFwd = 0
        }
    }
    @IBAction func targetRearSideSwitched(_ sender: UISwitch) {
        if sender.isOn == true {
            secondaryTargetRearSide = 2
        } else {
            secondaryTargetRearSide = 0
        }
    }
    
    @IBAction func indirectFireSwitched(_ sender: UISwitch) {
        if sender.isOn == true {
            indirectFire = 1
        } else {
            indirectFire = 0
        }
    }
    @IBAction func spottingSwitched(_ sender: UISwitch) {
        if sender.isOn == true {
            spotting = 1
        } else {
            spotting = 0
        }
    }
    
    
    @IBAction func doneButtonPressed(_ sender: UIButton) {
        
        totalOtherModifiers = sensorHit + shoulderHit + upperArmHit + lowerArmHit + secondaryTargetFwd + secondaryTargetRearSide + indirectFire + spotting
        
    otherModifiersDelegate.setOtherModifiers(total: totalOtherModifiers)
        
        self.dismiss(animated: true, completion: nil)
    }
    

}

protocol otherModifiersSelectionDelegate {
    func setOtherModifiers(total: Int)
}
