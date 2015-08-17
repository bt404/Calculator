//
//  ViewController.swift
//  Calculator
//
//  Created by knd2 on 15/8/16.
//  Copyright (c) 2015年 knd2. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    var userIsFirstlyInput: Bool = true

    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if (userIsFirstlyInput) {
            display.text = digit
            userIsFirstlyInput = false
        } else {
            display.text = display.text! + digit
        }
    }

    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if !userIsFirstlyInput {
            enter()
        }
        switch operation {
        case "✕": performOperation { $0 * $1 }
        case "÷": performOperation { $1 / $0 }
        case "+": performOperation { $0 + $1 }
        case "−": performOperation { $1 - $0 }
        case "√": performOperation { sqrt($0) }
        default: break
        }
    }
    
    private func performOperation (operation: Double -> Double) {
        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
    
    private func performOperation (operation: (Double, Double) -> Double) {
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
    var operandStack = Array<Double>()
    
    @IBAction func enter() {
        userIsFirstlyInput = true
        operandStack.append(displayValue)
    }
    
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            userIsFirstlyInput = true
        }
    }
}

