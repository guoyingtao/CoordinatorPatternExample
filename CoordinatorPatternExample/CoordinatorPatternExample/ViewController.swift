//
//  ViewController.swift
//  CoordinatorPatternExample
//
//  Created by Echo on 5/10/19.
//  Copyright © 2019 Echo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // MARK: navigation
    var showOperationAdd: ((_ number: Int)->Void)?
    var showOperationSubtraction: ((_ nubmer: Int)->Void)?
    
    @IBOutlet var resultField: UITextField!
    
    @IBOutlet var numberTextField: UITextField!
    
    func getNumber() -> Int {
        if let text = numberTextField.text {
            return Int(text) ?? 0
        }
        
        return 0
    }
    
    @IBAction func viewTapped(_ sender: Any) {
        numberTextField.resignFirstResponder()
    }
    
    @IBAction func operationAddTapped(_ sender: Any) {
        showOperationAdd?(getNumber())
    }
    
    @IBAction func operationSubtractionTapped(_ sender: Any) {
        showOperationSubtraction?(getNumber())
    }
    
    func setResult(_ result: Int) {
        resultField.text = "\(result)"
    }
}

