//
//  BaseCoordinatorFromNavigation.swift
//  SmartRecorder
//
//  Created by Echo on 5/7/19.
//  Copyright © 2019 Echo. All rights reserved.
//

import UIKit

class BaseNavigationCoordinator: NavigationCoordinator {
  var removeChildHandler: ((Coordinator, [AnyHashable : Any]?) -> Void)?
  
  var navigationController: UINavigationController?
  var childCoordinators: [Coordinator] = []
  var parent: Coordinator?
  
  required init(navigationController: UINavigationController?, parent: Coordinator?) {
    self.navigationController = navigationController
    self.parent = parent
  }
  
  func start() {
    
  }  
}
