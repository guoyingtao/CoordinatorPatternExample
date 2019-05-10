//
//  MainCoordinator.swift
//  CoordinatorPatternExample
//
//  Created by Echo on 5/10/19.
//  Copyright © 2019 Echo. All rights reserved.
//

import UIKit

class MainCoordinator: BaseNavigationCoordinator {
    override func start() {
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as? ViewController else {
            return
        }
        
        vc.showOperationAdd = { [weak self] number in
            self?.navigateToOperation(with: number)
        }
        
        vc.showOperationSubstraction = { [weak self, weak vc] number in
            guard let vc = vc else { return }
            self?.presentOperation(with: number, presentingViewController: vc)
        }
        
        navigationController?.pushViewController(vc, animated: false)
    }
    
    func navigateToOperation(with number: Int) {
        let coordinator = OperationCoordinator(number: number, navigationController: navigationController, parent: parent)
        coordinate(with: coordinator)
    }
    
    func presentOperation(with number: Int, presentingViewController: UIViewController) {
        let coordinator = OperationCoordinator(number: number, presentingViewController: presentingViewController, parent: parent)
        coordinate(with: coordinator)
    }
}
