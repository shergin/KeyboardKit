//
//  UIInputViewController+rootInputViewController.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 2/5/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import UIKit


private weak var storedInputViewController: UIInputViewController?
private var dispatchOnceToken: dispatch_once_t = 0

extension UIInputViewController {

    public override class func initialize() {
        dispatch_once(&dispatchOnceToken) {
            let type = UIViewController.self // Yes, `UIViewController`, not `UIInputViewController`.
            let originalMethod = class_getInstanceMethod(type, Selector("initWithNibName:bundle:"))

            let swizzledImplementation: @convention(c) (NSObject, Selector, AnyObject, AnyObject) -> Unmanaged<AnyObject>! = { (_self, _cmd, nibName, bundle) in
                if let inputViewController = _self as? UIInputViewController {
                    storedInputViewController = inputViewController
                }

                return _self.performSelector("originalInitWithNibName:bundle:", withObject: nibName, withObject: bundle)
            }

            let originalImplementation =
                method_setImplementation(
                    originalMethod,
                    unsafeBitCast(swizzledImplementation, IMP.self)
                )

            class_addMethod(
                type,
                "originalInitWithNibName:bundle:",
                originalImplementation,
                method_getTypeEncoding(originalMethod)
            )
        }
    }

    public static var rootInputViewController: UIInputViewController! {
        return storedInputViewController
    }
}
