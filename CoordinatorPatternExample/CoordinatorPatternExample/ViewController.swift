//
//  ViewController.swift
//  CoordinatorPatternExample
//
//  Created by Echo on 5/10/19.
//  Copyright © 2019 Echo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet var numberTextField: UITextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }

  @IBAction func viewTapped(_ sender: Any) {
    numberTextField.resignFirstResponder()
  }
  
}

