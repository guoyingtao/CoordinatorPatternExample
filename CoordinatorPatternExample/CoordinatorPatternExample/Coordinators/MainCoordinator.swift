//
//  MainCoordinator.swift
//  CoordinatorPatternExample
//
//  Created by Echo on 5/10/19.
//  Copyright © 2019 Echo. All rights reserved.
//

import UIKit

class MainCoordinator: BaseNavigationCoordinator {
    let id = "101"
    
    override func start() {
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as? ViewController else {
            return
        }
        
        vc.showOperationAdd = { [weak self] number in
            self?.navigateToOperation(with: number)
        }
        
        vc.showOperationSubtraction = { [weak self, weak vc] number in
            guard let vc = vc else { return }
            self?.presentOperation(with: number, presentingViewController: vc)
        }
        
        removeChildHandler = { [weak vc] child, info in
            guard let result = info?["result"] as? Int else {
                return
            }
            
            vc?.setResult(result)
        }
        
        navigate(vc, by: navigationController, animated: false)
    }
    
    func navigateToOperation(with number: Int) {
        let coordinator = OperationCoordinator(number: number, mode: .add, navigationController: navigationController, parent: self)
        coordinate(with: coordinator)
    }
    
    func presentOperation(with number: Int, presentingViewController: UIViewController) {
        let coordinator = OperationCoordinator(number: number, mode: .subtraction, presentingViewController: presentingViewController, parent: self)
        coordinate(with: coordinator)
    }
}
