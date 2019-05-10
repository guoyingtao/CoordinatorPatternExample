//
//  OperationCoordinator.swift
//  CoordinatorPatternExample
//
//  Created by Echo on 5/10/19.
//  Copyright © 2019 Echo. All rights reserved.
//

import UIKit

class OperationCoordinator: BaseVersatileCoordinator {
    
    var number: Int?
    
    convenience init(number: Int, navigationController: UINavigationController?, parent: Coordinator?) {
        self.init(navigationController: navigationController, parent: parent)
        self.number = number
    }
    
    convenience init(number: Int, presentingViewController: UIViewController?, parent: Coordinator?) {
        self.init(presentingViewController: presentingViewController, parent: parent)
        self.number = number
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
        return vc
    }
    
    override func start(from presentingVC: UIViewController) {
        guard let vc = createOperationViewController(with: number) else {
            return
        }
        
        vc.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Close", style: .plain, target: vc, action: #selector(OperationViewController.close))
        
        let nc = UINavigationController(rootViewController: vc)
        presentingVC.present(nc, animated: true)
    }
    
    override func start(from navigationController: UINavigationController) {
        guard let vc = createOperationViewController(with: number) else {
            return
        }
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showSettings() {
        
    }
}
