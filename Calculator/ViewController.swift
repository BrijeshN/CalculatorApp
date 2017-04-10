//
//  ViewController.swift
//  Calculator
//
//  Created by Brijesh Nayak on 2/26/17.
//  Copyright © 2017 Brijesh Nayak. All rights reserved.
//

import UIKit

// "enum" is used to create custom data type
enum modes {
    
    case not_set
    case addition
    case subtraction
    case multiplication
    
}

class ViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    
    var labelString: String = "0"
    var currentMode: modes = modes.not_set
    var savedNum: Int = 0
    var lastButtonWasMode: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // if user presses + button, store the current value and reset the text to "0"
    @IBAction func didPressPlus(_ sender: Any) {
        
        changeMode(newMode: .addition)
        
        
    }
    
    // if user presses - button, store the current value and reset the text to "0"
    @IBAction func didPressSuctract(_ sender: Any) {
        
        changeMode(newMode: .subtraction)
    }
    
    // if user presse * button, store the current value and reset the text to "0"
    @IBAction func didPressMultiply(_ sender: Any) {
        
        changeMode(newMode: .multiplication)
        
    }
    
    @IBAction func didPressEquals(_ sender: Any) {
        
        // this takes the string (ex. 000001) and convert it into a number (ex. 1)
        guard let labelInt:Int = Int(labelString) else {
            // if can't convert to number just return
            return
        }
        if(currentMode == .not_set || lastButtonWasMode) {
            // stop running this method
            return
        }
        if (currentMode == .addition) {
            savedNum += labelInt
        }
        else if (currentMode == .subtraction) {
            savedNum -= labelInt
        }
        else if (currentMode == .multiplication) {
            savedNum *= labelInt
        }
        
        currentMode = .not_set
        // to display final answer
        labelString = "\(savedNum)"
        updateText()
        lastButtonWasMode = true
        
    }
   
    // clear screen
    @IBAction func didPressClear(_ sender: Any) {
        
         labelString = "0"
         currentMode = .not_set
         savedNum = 0
         lastButtonWasMode = false
        
        // reset text
        label.text = "0"
        
    }
    
    // get number pressed and display
    @IBAction func didPressNumber(_ sender: UIButton) {
        
        // get the name of the button
        let stringValue: String? = sender.titleLabel?.text
        
        if (lastButtonWasMode) {
            lastButtonWasMode = false
            labelString = "0"
        }
        
        // Here we are chainging the value but havent updated a value (i.e 01123)
        labelString = labelString.appending(stringValue!)
        
        updateText()
        
    }
    
    // functin to update values in label
    func updateText() {
        
        // this takes the string (ex. 000001) and convert it into a number (ex. 1)
        guard let labelInt:Int = Int(labelString) else {
            // if can't convert to number just return
            return
        }
        
        // save the number before user presses "+", "-", "*"
        if (currentMode == .not_set) {
            savedNum = labelInt
        }
        
        // Constructor
        let formatter:NumberFormatter = NumberFormatter()
        formatter.numberStyle = .decimal
        let num:NSNumber = NSNumber(value: labelInt)
        
        // update the label
        label.text = formatter.string(from: num)
        
    }
    
    // to check what mode we are in (i.e mult, add, sub ...)
    func changeMode(newMode: modes) {
        
        if (savedNum == 0) {
            return
        }
        
        
        // if user presses "+", "-", "*" set the mode to currentMode
        currentMode = newMode
        lastButtonWasMode = true
        
        
    }
    
    


}

