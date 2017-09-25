//
//  ViewController.swift
//  caculator
//
//  Created by Zhengchengen on 2017/9/22.
//  Copyright © 2017年 Zhengchengen. All rights reserved.
//

import UIKit

enum modes{
    case not_set
    case addition
    case subtraction
    case multiply
    case Divide
}

class ViewController: UIViewController {
    var results: String = "0"
    var currentMode: modes = .not_set
    var savedNum: Double = 0
    var lastButtonWasMode: Bool = false
    
    @IBOutlet weak var lblResults: UILabel!
    
    @IBAction func btnDivide_Touch(_ sender: Any) {
        changeMode(newMode:.Divide)
    }
    
    @IBAction func btnAdd_Touch(_ sender: Any) {
        changeMode(newMode:.addition)
    }
    @IBAction func btnSubtract_Touch(_ sender: Any) {
        changeMode(newMode:.subtraction)
    }
    
    @IBAction func btnMultiply_Touch(_ sender: Any) {
        changeMode(newMode:.multiply)
    }
    @IBAction func btnEqual_Touch(_ sender: Any) {
        guard let resultsInt: Double = Double(results) else {
        return
        }
        if (lastButtonWasMode){
            return
        }
        switch currentMode {
        case .not_set:
            return
        case .addition:
            savedNum += resultsInt
        case .subtraction:
            savedNum -= resultsInt
        case .multiply:
            savedNum *= resultsInt
        case .Divide:
            savedNum /= resultsInt
        }
    currentMode = .not_set
        results = "\(savedNum)"
        updateText()
        lastButtonWasMode = true
}
    @IBAction func btnClear_Touch(_ sender: Any) {
        results = "0"
        currentMode = .not_set
        savedNum = 0
        lastButtonWasMode = false
        lblResults.text = "0"
    }
    
    @IBAction func btnNumber_Touch(_ sender: UIButton) {
        let selectedNumber:String? = sender.titleLabel?.text
        if(lastButtonWasMode){
            lastButtonWasMode = false
            results = "0"
        }
        
        results = results.appending(selectedNumber!)
        updateText()
        }
    
    func updateText(){
        guard let resultsInt: Double = Double(results)
            else { return
        }
        if (currentMode == .not_set){
            savedNum = resultsInt
        }
        let formatter: NumberFormatter = NumberFormatter()
        formatter.numberStyle = .decimal
        let num: NSNumber = NSNumber(value: resultsInt)
        lblResults.text = formatter.string(from: num)
        
    }
    
    func changeMode(newMode:modes){
        if (savedNum == 0){
            return
        }
        currentMode = newMode
        lastButtonWasMode = true
    }
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

