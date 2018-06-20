//
//  ViewController.swift
//  RetroCalculatorV1
//
//  Created by Kyla Wilson on 6/20/18.
//  Copyright © 2018 Kyla. All rights reserved.
//

import UIKit
import AVFoundation

class CalculatorVC: UIViewController {
    
    @IBOutlet weak var resultLbl: UILabel!
    
    var btnSound: AVAudioPlayer!
    
    var runningNumber = "";
    var leftValueStr = "";
    var rightValueStr = "";
    var result = "";
    
    enum Operator: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    var currentOperation = Operator.Empty;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = Bundle.main.path(forResource: "btn", ofType: "wav");
        let soundURL = URL(fileURLWithPath: path!);
        
        do {
            try btnSound = AVAudioPlayer(contentsOf: soundURL);
            btnSound.prepareToPlay();
        } catch let error as NSError {
            print(error.description);
        }
        
    }
    
    func PlayBtnSoundEfx() {
        if btnSound.isPlaying {
            btnSound.stop();
        }
        
        btnSound.play(); // Audio player
    }
    
    @IBAction func NumberPressed(sender: UIButton) {
        PlayBtnSoundEfx();
        runningNumber += "\(sender.tag)"; // Everytime a number is pressed it will be added to running number which is the value of the result.
        resultLbl.text = runningNumber;
        print(leftValueStr);
    }
    
    @IBAction func DividePressed(sender: Any) {
        ProcessOperation(operation: Operator.Divide);
    }
    
    @IBAction func MultiplyPressed(sender: Any) {
        ProcessOperation(operation: Operator.Multiply);
    }
    
    @IBAction func SubtractPressed(sender: Any) {
        ProcessOperation(operation: Operator.Subtract);
    }
    
    @IBAction func AddPressed(sender: Any) {
         ProcessOperation(operation: Operator.Add);
    }
    
    @IBAction func EqualPressed(sender: Any) {
        ProcessOperation(operation: currentOperation);
    }
    
    @IBAction func ClearPressed(sender: Any) {
        runningNumber = "";
        leftValueStr = "";
        rightValueStr = "";
        resultLbl.text = "";
        currentOperation = Operator.Empty;
    }
    
    func ProcessOperation(operation: Operator) {
        if(currentOperation != Operator.Empty) { // If operator is not empty anymore, When user presses an operation
            if runningNumber != "" { // Also, if user has also pressed a number
                rightValueStr = runningNumber; // Set right value to the running number, set running number equal to empty so the next number can be appened.
                runningNumber = ""; // running number will now be empty
                
                print(leftValueStr);
                print(rightValueStr)
                
                if currentOperation == Operator.Multiply { // If multiply pressed
                    result = "\(Double(leftValueStr)! * Double(rightValueStr)!)"; // Convert the strings into doubles and display the value in result.
                } else if currentOperation == Operator.Divide {
                     result = "\(Double(leftValueStr)! / Double(rightValueStr)!)";
                } else if currentOperation == Operator.Subtract {
                     result = "\(Double(leftValueStr)! - Double(rightValueStr)!)";
                } else if currentOperation == Operator.Add {
                     result = "\(Double(leftValueStr)! + Double(rightValueStr)!)";
                }
                
                leftValueStr = result;
                print(leftValueStr);
                resultLbl.text = result;
            }
            
            currentOperation = operation;
            
        } else { // IMPORTANT
            leftValueStr = runningNumber; // If the user did press an operation left value is equal to running number.
            runningNumber = "";
            currentOperation = operation;
        }
    }
    
    
}
