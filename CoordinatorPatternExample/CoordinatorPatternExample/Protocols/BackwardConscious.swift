//
//  BackwardConscious.swift
//  SmartRecorder
//
//  Created by Echo on 4/28/19.
//  Copyright © 2019 Echo. All rights reserved.
//

import UIKit

protocol BackwardConscious where Self: UIViewController {
    var backwardHandler: ((_ userInfo: [AnyHashable: Any]?)->Void)? { get set }
    func getUserInfo() -> [AnyHashable: Any]?
    
    /// Put this function inside the override function ViewWillDisappear(:)
    func checkIsBackingWard(with userInfo: [AnyHashable: Any]?)
}

extension BackwardConscious {
    func getUserInfo() -> [AnyHashable: Any]? {
        return nil
    }
    
    func checkIsBackingWard(with userInfo: [AnyHashable: Any]? = nil) {
        if isMovingFromParent {
            backwardHandler?(userInfo)
        } else {
            if let navigationController = self.navigationController {
                if navigationController.isBeingDismissed {
                    backwardHandler?(userInfo)
                }
            } else {
                if isBeingDismissed {
                    backwardHandler?(userInfo)
                }
            }      
        }
    }
}

private let swizzling: (AnyClass, Selector, Selector) -> () = { forClass, originalSelector, swizzledSelector in
    let originalMethod = class_getInstanceMethod(forClass, originalSelector)
    let swizzledMethod = class_getInstanceMethod(forClass, swizzledSelector)
    method_exchangeImplementations(originalMethod!, swizzledMethod!)
}

extension UIViewController {
    static let classInit: Void = {
        let originalSelector = #selector(viewWillDisappear(_:))
        let swizzledSelector = #selector(swizzledViewWillDisappear(_:))
        swizzling(UIViewController.self, originalSelector, swizzledSelector)
    }()
    
    @objc func swizzledViewWillDisappear(_ animated: Bool) {
        // Call the original viewDidAppear - using the swizzledViewDidAppear signature
        swizzledViewWillDisappear(animated)
        
        if let vc = self as? BackwardConscious {
            vc.checkIsBackingWard(with: vc.getUserInfo())
        }
    }
    
}
