//
//  BasePresentingCoordinator.swift
//  SmartRecorder
//
//  Created by Echo on 5/7/19.
//  Copyright © 2019 Echo. All rights reserved.
//

import UIKit

class BasePresentingCoordinator: PresentingCoordinator {
    var removeChildHandler: ((Coordinator, [AnyHashable : Any]?) -> Void)?
    
    required init(presentingViewController: UIViewController?, parent: Coordinator?) {
        self.presentingViewController = presentingViewController
        self.parent = parent
    }
    
    var presentingViewController: UIViewController?
    
    var childCoordinators: [Coordinator] = []
    
    var parent: Coordinator?
    
    func start() {
        
    }
}

