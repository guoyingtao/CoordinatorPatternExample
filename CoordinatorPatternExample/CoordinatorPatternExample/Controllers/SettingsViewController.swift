//
//  SettingsViewController.swift
//  CoordinatorPatternExample
//
//  Created by Echo on 5/10/19.
//  Copyright © 2019 Echo. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController, BackwardConscious {
    
    var backwardHandler: (([AnyHashable : Any]?) -> Void)?
    var showInfo: (()->Void)?
    
    var initialNumber = 100 {
        didSet {
            numberLabel.text = "\(initialNumber)"
        }
    }

    @IBOutlet var stepper: UIStepper!
    @IBOutlet var numberLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Info", style: .plain, target: self, action: #selector(showInfoAction))
        
        initialNumber = 100        
        stepper.maximumValue = 10000
        stepper.minimumValue = 0
        stepper.value = Double(initialNumber)
    }
    
    @objc func showInfoAction() {
        showInfo?()
    }
    
    @IBAction func stepperTapped(_ stepper: UIStepper) {
        initialNumber = Int(stepper.value)
    }
    
    func getPassingInfo() -> [AnyHashable : Any]? {
        return ["initialNumber": initialNumber]
    }
}
