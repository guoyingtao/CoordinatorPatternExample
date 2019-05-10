//
//  Coordinator.swift
//  SmartRecorder
//
//  Created by Echo on 4/22/19.
//  Copyright © 2019 Echo. All rights reserved.
//

import Foundation
import UIKit

protocol Coordinator: class {
  var childCoordinators: [Coordinator] { get set }
  var parent: Coordinator? { get set }
  
  func add(childCoordinator coordinator: Coordinator)
  func remove(childCoordinator coordinator: Coordinator)  
  func start()

  var removeChildHandler: ((Coordinator, _ userInfo: [AnyHashable: Any]?)->Void)? { get set }

  func didFinish(with userInfo: [AnyHashable: Any]?)
}

extension Coordinator  {
  func didFinish(with userInfo: [AnyHashable: Any]? = nil) {
    if let parent = parent {
      parent.removeChildHandler?(self, userInfo)
      parent.remove(childCoordinator: self)
    }
  }
  
  func setDefaultBackwardHandler(with viewController: UIViewController) {
    if let vc = viewController as? BackwardConscious {
      vc.backwardHandler = { [weak self] userInfo in
        self?.didFinish(with: userInfo)
      }
    }
  }
  
  func add(childCoordinator coordinator: Coordinator) {
    childCoordinators.append(coordinator)
  }
  
  func remove(childCoordinator coordinator: Coordinator) {
    childCoordinators.removeAll { $0 === coordinator }
  }
  
  func coordinate(with coordinator: Coordinator) {
    add(childCoordinator: coordinator)
    coordinator.start()
  }
}

protocol UICoordinatorFromPresenting: Coordinator {
  var presentingViewController: UIViewController? { get set }
  init(presentingViewController: UIViewController?, parent: Coordinator?)
}

extension UICoordinatorFromPresenting {
  func present(_ viewController: UIViewController, by presentingViewController: UIViewController?, animated: Bool = true) {
    
    guard let presentingViewController = presentingViewController else {
      return
    }
    
    if let nc = viewController as? UINavigationController, let vc = nc.viewControllers.first {
      setDefaultBackwardHandler(with: vc)
    } else {
      setDefaultBackwardHandler(with: viewController)
    }
    
    presentingViewController.present(viewController, animated: animated)
  }
}

protocol UICoordinatorFromNavigation: Coordinator {
  var navigationController: UINavigationController? { get set }
  init(navigationController: UINavigationController?, parent: Coordinator?)
}

extension UICoordinatorFromNavigation {
  func navigate(_ viewController: UIViewController, by navigationController: UINavigationController?, animated: Bool = true) {
    guard let navigationController = navigationController else {
      return
    }
    
    setDefaultBackwardHandler(with: viewController)
    navigationController.pushViewController(viewController, animated: animated)
  }
}

protocol UICoordinator: UICoordinatorFromNavigation, UICoordinatorFromPresenting {
  func start(from navigationController: UINavigationController)
  func start(from presentVC: UIViewController)
}

extension UICoordinator {
  func start() {
    if let presentVC = presentingViewController {
      start(from: presentVC)
    } else if let navigationController = navigationController {
      start(from: navigationController)
    }
  }
}

