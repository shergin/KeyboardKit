//
//  UIInputViewController+rootInputViewController.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 2/5/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import UIKit


private var storedInputViewConrollers = WeakSet<UIInputViewController>()

private weak var storedInputViewController: UIInputViewController?
private var dispatchOnceToken: dispatch_once_t = 0

private var inputWindowObserver = InputWindowObserver()

extension UIInputViewController {

    public override class func initialize() {
        dispatch_once(&dispatchOnceToken) {
            let type = UIViewController.self // Yes, `UIViewController`, not `UIInputViewController`.
            let originalMethod = class_getInstanceMethod(type, Selector("initWithNibName:bundle:"))

            let swizzledImplementation: @convention(c) (NSObject, Selector, AnyObject, AnyObject) -> Unmanaged<AnyObject>! = { (_self, _cmd, nibName, bundle) in
                if let inputViewController = _self as? UIInputViewController {
                    storedInputViewController = inputViewController
                    storedInputViewConrollers.insert(inputViewController)
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

            let _ = inputWindowObserver
        }
    }

    private static func selectVisibleRootViewController(visibleWindow: UIWindow) {
        var visibleInputViewConroller: UIInputViewController?
        for inputViewConroller in storedInputViewConrollers {
            guard let window = inputViewConroller.view.window else {
                continue
            }

            if window == visibleWindow {
                visibleInputViewConroller = inputViewConroller
                break
            }
        }

        if let viewController = visibleInputViewConroller where viewController != storedInputViewController {
            storedInputViewController = viewController
        }
    }

    public static var rootInputViewController: UIInputViewController {
        return storedInputViewController!
    }

    internal static var isRootInputViewControllerAvailable: Bool {
        return storedInputViewController != nil
    }
}

class InputWindowObserver: NSObject {
    override init() {
        super.init()

        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(handleWindowDidBecomeVisible), name: UIWindowDidBecomeVisibleNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(handleWindowDidBecomeHidden), name: UIWindowDidBecomeHiddenNotification, object: nil)
    }

    func handleWindowDidBecomeVisible(notification: NSNotification) {
        print("handleWindowDidBecomeVisible: \(notification.object)")

        UIInputViewController.selectVisibleRootViewController(notification.object as! UIWindow)
    }

    func handleWindowDidBecomeHidden(notification: NSNotification) {
        print("handleWindowDidBecomeHidden: \(notification.object)")
    }
}
