//
//  AppCoordinator.swift
//  SmartRecorder
//
//  Created by Echo on 4/27/19.
//  Copyright © 2019 Echo. All rights reserved.
//

import UIKit

class AppCoordinator: NSObject, Coordinator {
  var removeChildHandler: ((Coordinator, [AnyHashable : Any]?) -> Void)?
  
  weak var parent: Coordinator? = nil
  
  var childCoordinators: [Coordinator] = []
  let navigationController: UINavigationController
  
  private let window: UIWindow
  
  init(window: UIWindow) {
    self.window = window
    self.navigationController = UINavigationController()
    
    self.window.rootViewController = navigationController
    self.window.makeKeyAndVisible()
  }
  
  func start() {
    let coordinator = MainCoordinator(navigationController: self.navigationController, parent: self)
    add(childCoordinator: coordinator)
    coordinator.start()
  }
}
