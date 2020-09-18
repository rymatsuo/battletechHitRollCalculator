//
//  ViewController.swift
//  Battletech Hit Roll Calculator
//
//  Created by User on 1/14/20.
//  Copyright © 2020 Ryan Matsuo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //MARK: Storyboard Outlet Declrations
    
    @IBOutlet weak var titleTextLabel: UILabel!
    @IBOutlet weak var targetMovePicker: UIPickerView!
    @IBOutlet weak var gunneryTextLabel: UILabel!
    @IBOutlet weak var attackerMovementTextLable: UILabel!
    @IBOutlet weak var targetMovementLabel: UILabel!
    @IBOutlet weak var otherModifiersTextLabel: UILabel!
    @IBOutlet weak var rangeTextLabel: UILabel!
    @IBOutlet weak var calculateButtonTextLabel: UIButton!
    @IBOutlet weak var jumpedSwitchOutlet: UISwitch!
    @IBOutlet weak var minRangeView: UIView!
    @IBOutlet weak var minRangeTitleLabel: UILabel!
    @IBOutlet weak var weaponMinRangeTextLabel: UILabel!
    @IBOutlet weak var minRangeTargetRangeLabel: UILabel!
    @IBOutlet weak var minRangeTargetRangeStepperOutlet: UIStepper!
    @IBOutlet weak var minRangeTargetRangeLabelOutlet: UILabel!
    
    //Range StackView Button Outlets
    @IBOutlet weak var shortRangeButtonTitle: UIButton!
    @IBOutlet weak var mediumRangeButtonTitle: UIButton!
    @IBOutlet weak var longRangeButtonTitle: UIButton!
    @IBOutlet weak var minRangeButtonTitle: UIButton!
    
    let data = ["0-2 HEXES", "3-4 HEXES", "5-6 HEXES", "7-9 HEXES", "10-17 HEXES", "18-24 HEXES", "25+ HEXES", "PRONE", "PRONE(ADJACENT)", "IMMOBILE"]
    
    //MARK: viewDidLoad custom code
    
    override func viewDidLoad() {
        super.viewDidLoad()
        targetMovePicker.dataSource = self
        targetMovePicker.delegate = self
        minRangeView.alpha = 0
        
        titleTextLabel.font = UIFont(name: "Battletech", size: 20.0)
        gunneryTextLabel.font = UIFont(name: "HMType", size: 20.0)
        attackerMovementTextLable.font = UIFont(name: "HMType", size: 20.0)
        targetMovementLabel.font = UIFont(name: "HMType", size: 20.0)
        otherModifiersTextLabel.font = UIFont(name: "HMType", size: 20.0)
        rangeTextLabel.font = UIFont(name: "HMType", size: 20.0)
        calculateButtonTextLabel.titleLabel?.font = UIFont(name: "HMType", size: 20.0)
        shortRangeButtonTitle.setTitleColor(.systemRed, for: .normal)
        minRangeView.layer.cornerRadius = 25
        minRangeTitleLabel.font = UIFont(name: "Battletech", size: 17.0)
        weaponMinRangeTextLabel.font = UIFont(name: "HMType", size: 15.0)
        minRangeTargetRangeLabel.font = UIFont(name: "HMType", size: 15.0)
    }
    
    //MARK: Variable declartions/initializations
    var gunnery = 4
    var attackerMovement = 1
    var targetMovement = 0
    var jumped = 0
    var partialCover = 0
    var otherModifiers = 0
    var lightWoods = 0
    var heavyWoods = 0
    var heat = 0
    var range = 0
    var hitNumber = 0
    var weaponMinRange = 2
    var weaponMinRangeTargeRange = 2
    
    @IBOutlet weak var gunnerySkillOutlet: UISlider!
    @IBOutlet weak var attackerMovementOutlet: UISlider!
    @IBAction func jumpedSwitchMoved(_ sender: UISwitch) {
        if (sender.isOn == true) {
            jumped = 1
        } else {
            jumped = 0
        }
    }
    
    //MARK: HANDLING GUNNERY SKILL MODIFIER
    
    @IBAction func gunnerySliderMoved(_ sender: UISlider) {
        gunnerySkillOutlet.value = roundf(gunnerySkillOutlet.value)
        gunnery = Int(gunnerySkillOutlet.value)
    }
    
    //MARK: HANDLING ATTACKER MOVEMENT MODIFIER
    
    @IBAction func attackSliderMoved(_ sender: UISlider) {
        attackerMovementOutlet.value = roundf(attackerMovementOutlet.value)
        
        let attackMoveIndex = attackerMovementOutlet.value
        switch attackMoveIndex {
        case 0:
            attackerMovement = 0
        case 1:
            attackerMovement = 1
        case 2:
            attackerMovement = 2
        case 3:
            attackerMovement = 3
        case 4:
            attackerMovement = 2
        default:
            attackerMovement = 1
            
        }
        if attackerMovementOutlet.value < 4 {
            attackerMovement = Int(attackerMovementOutlet.value)
        } else {
            attackerMovement = 2
        }
    }
    
    //MARK: HANDLING PARTIAL COVER MODIFIER
    
    @IBAction func partialCoverSwitchMoved(_ sender: UISwitch) {
        if (sender.isOn == true) {
            partialCover = 1
        } else {
            partialCover = 0
        }
    }
    
    //MARK: HANDLING LIGHT WOODS MODIFIER
    
    @IBAction func lightWoodsControlMoved(_ sender: UISegmentedControl) { lightWoods = sender.selectedSegmentIndex
    }
    
    //MARK: HANDLING HEAVY WOODS MODIFIER
    
    @IBAction func heavyWoodsControlMoved(_ sender: UISegmentedControl) {
        let heavyWoodsIndex = sender.selectedSegmentIndex
        switch heavyWoodsIndex {
        case 0:
            heavyWoods = 0
        case 1:
            heavyWoods = 2
        case 2:
            heavyWoods = 4
        default:
            heavyWoods = 0
        }
    }
    
    //MARK: HANDLING HEAT MODIFIER
    
    @IBAction func heatControlMoved(_ sender: UISegmentedControl) {
        let index = sender.selectedSegmentIndex
        switch index {
        case 0:
            heat = 0
        case 1:
            heat = 1
        case 2:
            heat = 2
        case 3:
            heat = 3
        case 4:
            heat = 4
        default:
            heat = 0
        }
    }
    
    //MARK: HANDLING ADDITIONAL MODIFIERS
    
    @IBAction func additionalModifiersPressed(_ sender: UIButton) {
        let otherModifiersVC = storyboard?.instantiateViewController(identifier: "otherModifiers") as! OtherModifiersViewController
        otherModifiersVC.otherModifiersDelegate = self
        present(otherModifiersVC, animated: true, completion: nil)
    }
    
    //MARK: HANDLING RANGE MODIFERS
    
    @IBAction func minRangeButtonPressed(_ sender: UIButton) {
        
        minRangeButtonTitle.setTitleColor(.systemRed, for: .normal)
        shortRangeButtonTitle.setTitleColor(.darkGray, for: .normal)
        mediumRangeButtonTitle.setTitleColor(.darkGray, for: .normal)
        longRangeButtonTitle.setTitleColor(.darkGray, for: .normal)
        minRangeView.alpha = 1
    }
    
    @IBAction func weaponMinRangeControlMoved(_ sender: UISegmentedControl) {
       
        let weaponMinRangeIndex = sender.selectedSegmentIndex
        switch weaponMinRangeIndex {
        case 0:
            weaponMinRange = 2
        case 1:
            weaponMinRange = 3
        case 2:
            weaponMinRange = 4
        case 3:
            weaponMinRange = 5
        case 4:
            weaponMinRange = 6
        case 5:
            weaponMinRange = 10
        default:
            weaponMinRange = 0
        }
        switch weaponMinRange {
        case 2:
            minRangeTargetRangeStepperOutlet.maximumValue = 2
            minRangeTargetRangeStepperOutlet.value = Double(weaponMinRange)
            minRangeTargetRangeLabelOutlet.text = "\(weaponMinRange)"
            weaponMinRangeTargeRange = weaponMinRange
            
        case 3:
            minRangeTargetRangeStepperOutlet.maximumValue = 3
            minRangeTargetRangeStepperOutlet.value = Double(weaponMinRange)
            minRangeTargetRangeLabelOutlet.text = "\(weaponMinRange)"
            weaponMinRangeTargeRange = weaponMinRange
            
        case 4:
            minRangeTargetRangeStepperOutlet.maximumValue = 4
            minRangeTargetRangeStepperOutlet.value = Double(weaponMinRange)
            minRangeTargetRangeLabelOutlet.text = "\(weaponMinRange)"
            weaponMinRangeTargeRange = weaponMinRange
            
        case 5:
            minRangeTargetRangeStepperOutlet.maximumValue = 5
            minRangeTargetRangeStepperOutlet.value = Double(weaponMinRange)
            minRangeTargetRangeLabelOutlet.text = "\(weaponMinRange)"
            weaponMinRangeTargeRange = weaponMinRange
            
        case 6:
            minRangeTargetRangeStepperOutlet.maximumValue = 6
            minRangeTargetRangeStepperOutlet.value = Double(weaponMinRange)
            minRangeTargetRangeLabelOutlet.text = "\(weaponMinRange)"
            weaponMinRangeTargeRange = weaponMinRange
           
        case 10:
            minRangeTargetRangeStepperOutlet.maximumValue = 10
            minRangeTargetRangeStepperOutlet.value = Double(weaponMinRange)
            minRangeTargetRangeLabelOutlet.text = "\(weaponMinRange)"
            weaponMinRangeTargeRange = weaponMinRange
            
        default:
            minRangeTargetRangeStepperOutlet.maximumValue = 2
            minRangeTargetRangeStepperOutlet.value = Double(weaponMinRange)
            minRangeTargetRangeLabelOutlet.text = "\(weaponMinRange)"
            weaponMinRangeTargeRange = weaponMinRange
        }
    }
    @IBAction func minRangerStepperPressed(_ sender: UIStepper) {
 //       minRangeTargetRangeLabelOutlet.text = "\(weaponMinRangeTargeRange)"
//        weaponMinRangeTargeRange = Int(minRangeTargetRangeStepperOutlet.value)
        minRangeTargetRangeLabelOutlet.text = "\(Int(minRangeTargetRangeStepperOutlet.value))"
        weaponMinRangeTargeRange = Int(minRangeTargetRangeStepperOutlet.value)
    }
    
    @IBAction func shortRangeButtonPressed(_ sender: UIButton) {
        range = 0
        //Set Text color on button to red to denote selection
        shortRangeButtonTitle.setTitleColor(.systemRed, for: .normal)
        mediumRangeButtonTitle.setTitleColor(.darkGray, for: .normal)
        longRangeButtonTitle.setTitleColor(.darkGray, for: .normal)
        minRangeButtonTitle.setTitleColor(.darkGray, for: .normal)}
    
    @IBAction func mediumRangeButtonPressed(_ sender: UIButton) {
        range = 2
        mediumRangeButtonTitle.setTitleColor(.systemRed, for: .normal)
        shortRangeButtonTitle.setTitleColor(.darkGray, for: .normal)
        longRangeButtonTitle.setTitleColor(.darkGray, for: .normal)
        minRangeButtonTitle.setTitleColor(.darkGray, for: .normal)
    }
    
    @IBAction func longRangeButtonPressed(_ sender: UIButton) {
        range = 4
        longRangeButtonTitle.setTitleColor(.systemRed, for: .normal)
        shortRangeButtonTitle.setTitleColor(.darkGray, for: .normal)
        mediumRangeButtonTitle.setTitleColor(.darkGray, for: .normal)
        minRangeButtonTitle.setTitleColor(.darkGray, for: .normal)
    }
    
    @IBAction func minRangeDoneButtonPressed(_ sender: UIButton) {
        
        range = weaponMinRange -  weaponMinRangeTargeRange + 1
        minRangeView.alpha = 0
    }
    
    //MARK: HANDLING FINAL TO HIT CALCULATION
    
    @IBAction func calculateButtonPressed(_ sender: UIButton) {
        
        hitNumber = gunnery + attackerMovement + targetMovement + jumped + partialCover + lightWoods + heavyWoods + heat + otherModifiers + range
        
        self.performSegue(withIdentifier: "calculateHitNumber", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "calculateHitNumber" {
            let destinationVC = segue.destination as! CalculateViewController
            destinationVC.toHitNumber = hitNumber
        }
    }
}

//MARK: CLASS EXTENSIONS

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch row {
        case 0:
            targetMovement = 0
            jumpedSwitchOutlet.isEnabled = true
        case 1:
            targetMovement = 1
            jumpedSwitchOutlet.isEnabled = true
        case 2:
            targetMovement = 2
            jumpedSwitchOutlet.isEnabled = true
        case 3:
            targetMovement = 3
            jumpedSwitchOutlet.isEnabled = true
        case 4:
            targetMovement = 4
            jumpedSwitchOutlet.isEnabled = true
        case 5:
            targetMovement = 5
            jumpedSwitchOutlet.isEnabled = true
        case 6:
            targetMovement = 6
            jumpedSwitchOutlet.isEnabled = true
        case 7:
            targetMovement = 1
            jumpedSwitchOutlet.isEnabled = false
            jumpedSwitchOutlet.isOn = false
        case 8:
            targetMovement = -2
            jumpedSwitchOutlet.isEnabled = false
            jumpedSwitchOutlet.isOn = false
        case 9:
            targetMovement = -4
            jumpedSwitchOutlet.isEnabled = false
            jumpedSwitchOutlet.isOn = false
        default:
            targetMovement = 0
        }
    }
}

extension ViewController: otherModifiersSelectionDelegate {
    func setOtherModifiers(total: Int) {
        otherModifiers = total
    }
}

