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
        
        vc.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(close))

        
        let nc = UINavigationController(rootViewController: vc)
        vc.showInfo = { [weak self] in
            self?.navigateToInfo(with: nc)
        }

        present(nc, by: presentingViewController)
    }
    
    @objc func close() {
        presentingViewController?.dismiss(animated: true)
    }
    
    func navigateToInfo(with navigationController: UINavigationController) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InfoViewController")
        navigationController.pushViewController(vc, animated: true)
    }
}
