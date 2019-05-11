//
//  OperationViewController.swift
//  CoordinatorPatternExample
//
//  Created by Echo on 5/10/19.
//  Copyright © 2019 Echo. All rights reserved.
//

import UIKit

class OperationViewController: UIViewController, BackwardConscious {
    var backwardHandler: (([AnyHashable : Any]?) -> Void)?
    
    var number = 0
    var mode: OperationMode = .add
    
    private let varibleNumber = 10
    
    private var result = 0 {
        didSet {
            resultLabel.text = "\(result)"
        }
    }

    @IBOutlet var numberLabel: UILabel!
    @IBOutlet var operationLabel: UILabel!
    @IBOutlet var varibleNumberLabel: UILabel!
    @IBOutlet var resultLabel: UILabel!
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        checkIsBacking(with: ["result": result])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch mode {
        case .add:
            operationLabel.text = "+"
        default:
            operationLabel.text = "-"
        }
                
        result = number
        numberLabel.text = "\(number)"
        varibleNumberLabel.text = "\(varibleNumber)"
    }
    
    
    @IBAction func run(_ sender: Any) {
        switch mode {
        case .add:
            result += varibleNumber
        default:
            result -= varibleNumber
        }
    }
        
    @objc func close() {
        dismiss(animated: true)
    }
}
