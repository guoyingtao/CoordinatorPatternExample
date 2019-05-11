//
//  SettingsCoordinator.swift
//  CoordinatorPatternExample
//
//  Created by Echo on 5/11/19.
//  Copyright © 2019 Echo. All rights reserved.
//

import UIKit

class SettingsCoordinator: BasePresentingCoordinator {
    
    override func start() {
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SettingsViewController") as? SettingsViewController else {
            return
        }
        
        let nc = UINavigationController(rootViewController: vc)
        vc.showInfo = { [weak self] in
            self?.navigateToInfo(with: nc)
        }

        present(nc, by: presentingViewController)
    }
    
    func navigateToInfo(with navigationController: UINavigationController) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InfoViewController")
        navigationController.pushViewController(vc, animated: true)
    }
}
