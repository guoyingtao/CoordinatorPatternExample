//
//  BackwardConscious.swift
//  SmartRecorder
//
//  Created by Echo on 4/28/19.
//  Copyright © 2019 Echo. All rights reserved.
//

import UIKit

protocol BackwardConscious where Self: UIViewController {
    var backwardHandler: ((_ passingInfo: [AnyHashable: Any]?)->Void)? { get set }
    
    func getPassingInfo() -> [AnyHashable: Any]?
    func checkIsBackingWard(with passingInfo: [AnyHashable: Any]?)
}

extension BackwardConscious {
    func getPassingInfo() -> [AnyHashable: Any]? {
        return nil
    }
    
    func checkIsBackingWard(with passingInfo: [AnyHashable: Any]? = nil) {
        if isMovingFromParent {
            backwardHandler?(passingInfo)
        } else {
            if let navigationController = self.navigationController {
                if navigationController.isBeingDismissed {
                    backwardHandler?(passingInfo)
                }
            } else {
                if isBeingDismissed {
                    backwardHandler?(passingInfo)
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
        // Call the original viewDidDisappear - using the swizzledViewWillDisappear signature
        swizzledViewWillDisappear(animated)
        
        if let vc = self as? BackwardConscious {
            vc.checkIsBackingWard(with: vc.getPassingInfo())
        }
    }
    
}
