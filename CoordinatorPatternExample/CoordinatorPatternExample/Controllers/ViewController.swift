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
    var showSettings: (()->Void)?
    
    @IBOutlet var resultField: UITextField!
    
    @IBOutlet var numberTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Settings", style: .plain, target: self, action: #selector(showSettingsAction))
    }
    
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
    
    @objc func showSettingsAction() {
        showSettings?()
    }
    
    func setResult(_ result: Int) {
        resultField.text = "\(result)"
    }
    
    func setInitialNumber(_ number: Int) {
        numberTextField.text = "\(number)"
    }
}

