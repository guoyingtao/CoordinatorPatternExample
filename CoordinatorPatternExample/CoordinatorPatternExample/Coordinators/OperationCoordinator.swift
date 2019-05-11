//
//  OperationCoordinator.swift
//  CoordinatorPatternExample
//
//  Created by Echo on 5/10/19.
//  Copyright © 2019 Echo. All rights reserved.
//

import UIKit

enum OperationMode {
    case add
    case subtraction
}

class OperationCoordinator: BaseVersatileCoordinator {
    
    var number: Int?
    var mode: OperationMode = .add
    
    deinit {
        print("OperationCoordinator deinit")
    }
    
    convenience init(number: Int, mode: OperationMode, navigationController: UINavigationController?, parent: Coordinator?) {
        self.init(navigationController: navigationController, parent: parent)
        self.number = number
        self.mode = mode
    }
    
    convenience init(number: Int, mode: OperationMode, presentingViewController: UIViewController?, parent: Coordinator?) {
        self.init(presentingViewController: presentingViewController, parent: parent)
        self.number = number
        self.mode = mode
    }
    
    required init(navigationController: UINavigationController?, parent: Coordinator?) {
        super.init(navigationController: navigationController, parent: parent)
    }
    
    required init(presentingViewController: UIViewController?, parent: Coordinator?) {
        super.init(presentingViewController: presentingViewController, parent: parent)
    }
    
    func createOperationViewController(with number: Int?) -> OperationViewController? {
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "OperationViewController") as? OperationViewController,
            let number = number else {
            return nil
        }
        
        vc.number = number
        vc.mode = mode
                
        return vc
    }
    
    override func start(from presentingVC: UIViewController) {
        guard let vc = createOperationViewController(with: number) else {
            return
        }
        
        vc.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: .plain, target: vc, action: #selector(OperationViewController.close))
        
        let nc = UINavigationController(rootViewController: vc)
        
        present(vc, with: nc, by: presentingVC)
    }
    
    override func start(from navigationController: UINavigationController) {
        guard let vc = createOperationViewController(with: number) else {
            return
        }
        
        navigate(vc, by: navigationController)
    }    
}
