//
//  BaseVersatileCoordinator.swift
//  SmartRecorder
//
//  Created by Echo on 5/7/19.
//  Copyright © 2019 Echo. All rights reserved.
//

import UIKit

class BaseVersatileCoordinator: VersatileCoordinator {
  var removeChildHandler: ((Coordinator, [AnyHashable : Any]?) -> Void)?
  
  var navigationController: UINavigationController?
  
  deinit {
    print("BaseVersatileCoordinator deinit")
  }
  
  required init(navigationController: UINavigationController?, parent: Coordinator?) {
    self.navigationController = navigationController
    self.parent = parent
  }
  
  var presentingViewController: UIViewController?
  
  required init(presentingViewController: UIViewController?, parent: Coordinator?) {
    self.presentingViewController = presentingViewController
    self.parent = parent
  }
  
  var childCoordinators: [Coordinator] = []
  
  var parent: Coordinator?
  
  
  func start(from navigationController: UINavigationController) {
    
  }
  
  func start(from presentVC: UIViewController) {
    
  }  
}
