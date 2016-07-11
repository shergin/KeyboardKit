//
//  UIInputViewController+rootInputViewController.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 2/5/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import UIKit


private var storedInputViewControllers = WeakSet<UIInputViewController>()
private weak var storedInputViewController: UIInputViewController?
private var dispatchOnceToken: dispatch_once_t = 0


func swizzleInit() {
    let type = UIViewController.self // Yes, `UIViewController`, not `UIInputViewController`.
    let originalMethod = class_getInstanceMethod(type, Selector("initWithNibName:bundle:"))

    let swizzledImplementation: @convention(c) (NSObject, Selector, AnyObject, AnyObject) -> Unmanaged<AnyObject>! = { (_self, _cmd, nibName, bundle) in
        if let inputViewController = _self as? UIInputViewController {
            storedInputViewController = inputViewController
            storedInputViewControllers.insert(inputViewController)
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


func swizzleSendEvent() {
    let type = UIApplication.self
    let originalMethod = class_getInstanceMethod(type, Selector("sendEvent:"))

    let swizzledImplementation: @convention(c) (UIApplication, Selector, UIEvent) -> Unmanaged<AnyObject>! = { (_self, _cmd, event) in
        if let view = event.allTouches()?.first?.view {
            if let rootViewController = view.window?.rootViewController?.childViewControllers.first as? UIInputViewController {
                if storedInputViewController != rootViewController {
                    storedInputViewController = rootViewController
                    log("🙀🔥 `UIInputViewController.rootInputViewController` was recovered.")
                }
            }
        }

        return _self.performSelector("originalSendEvent:", withObject: event)
    }

    let originalImplementation =
        method_setImplementation(
            originalMethod,
            unsafeBitCast(swizzledImplementation, IMP.self)
    )

    class_addMethod(
        type,
        "originalSendEvent:",
        originalImplementation,
        method_getTypeEncoding(originalMethod)
    )
}


extension UIInputViewController {

    public override class func initialize() {
        dispatch_once(&dispatchOnceToken) {
            swizzleInit()
            swizzleSendEvent()
        }
    }

    public static var rootInputViewController: UIInputViewController {
        if let inputViewController = storedInputViewController {
            return inputViewController
        }

        guard let rootInputViewController = storedInputViewControllers.first else {
            fatalError("UIInputViewController: `rootInputViewController` was requested but there is no any.")
        }

        return rootInputViewController
    }

    internal static var optionalRootInputViewController: UIInputViewController? {
        if storedInputViewController == nil {
            log("👻💥 `UIInputViewController.optionalRootInputViewController` was requested but it is nil.")
        }

        return storedInputViewController
    }

    internal static var isRootInputViewControllerAvailable: Bool {
        return storedInputViewController != nil
    }

}
