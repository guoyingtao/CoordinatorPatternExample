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
    
    /// Put this function inside the override function ViewWillDisappear(:)
    func checkIsBackingWard(with userInfo: [AnyHashable: Any]?)
}

extension BackwardConscious {
    
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
