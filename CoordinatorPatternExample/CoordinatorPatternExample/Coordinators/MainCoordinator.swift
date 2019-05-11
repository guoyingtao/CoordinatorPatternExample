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
        
        vc.showSettings = { [weak self, weak vc] in
            self?.presentSettings(with: vc)
        }
        
        removeChildHandler = { [weak vc] child, info in
            if child is OperationCoordinator, let result = info?["result"] as? Int  {
                vc?.setResult(result)
                return
            }
            
            if child is SettingsCoordinator, let number = info?["initialNumber"] as? Int {
                vc?.setInitialNumber(number)
                return
            }            
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
    
    func presentSettings(with presentingViewController: UIViewController?) {
        let coordinator = SettingsCoordinator(presentingViewController: presentingViewController, parent: self)
        coordinate(with: coordinator)
    }    
}
