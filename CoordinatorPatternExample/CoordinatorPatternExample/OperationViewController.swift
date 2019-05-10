//
//  OperationViewController.swift
//  CoordinatorPatternExample
//
//  Created by Echo on 5/10/19.
//  Copyright © 2019 Echo. All rights reserved.
//

import UIKit

class OperationViewController: UIViewController {
    // MARK: navigation
    var showSetting: ()->Void = {}
    
    var number: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc func close() {
        dismiss(animated: true)
    }
}
