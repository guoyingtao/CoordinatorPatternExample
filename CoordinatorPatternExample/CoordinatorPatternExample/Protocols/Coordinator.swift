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
    
    func setDefaultBackwardHandler(with viewController: BackwardConscious) {
        viewController.backwardHandler = { [weak self] userInfo in
            self?.didFinish(with: userInfo)
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

// MARK: PresentingCoordinator
protocol PresentingCoordinator: Coordinator {
    var presentingViewController: UIViewController? { get set }
    init(presentingViewController: UIViewController?, parent: Coordinator?)
}

extension PresentingCoordinator {
    func present(_ viewController: BackwardConscious, with navigationController: UINavigationController? = nil, by presentingViewController: UIViewController?, animated: Bool = true) {
        
        guard let presentingViewController = presentingViewController else {
            return
        }
        
        setDefaultBackwardHandler(with: viewController)
        
        if let nc = navigationController {
            presentingViewController.present(nc, animated: animated)
        } else {
            presentingViewController.present(viewController, animated: animated)
        }
    }
}

// MARK: NavigationCoordinator
protocol NavigationCoordinator: Coordinator {
    var navigationController: UINavigationController? { get set }
    init(navigationController: UINavigationController?, parent: Coordinator?)
}

extension NavigationCoordinator {
    func navigate(_ viewController: BackwardConscious, by navigationController: UINavigationController?, animated: Bool = true) {
        guard let navigationController = navigationController else {
            return
        }
        
        setDefaultBackwardHandler(with: viewController)
        navigationController.pushViewController(viewController, animated: animated)
    }
}

// MARK: VersatileCoordinator
protocol VersatileCoordinator: NavigationCoordinator, PresentingCoordinator {
    func start(from navigationController: UINavigationController)
    func start(from presentVC: UIViewController)
}

extension VersatileCoordinator {
    func start() {
        if let presentVC = presentingViewController {
            start(from: presentVC)
        } else if let navigationController = navigationController {
            start(from: navigationController)
        }
    }
}

