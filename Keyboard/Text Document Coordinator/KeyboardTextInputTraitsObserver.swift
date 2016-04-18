//
//  KeyboardTextInputTraitsObserver.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 1/15/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import UIKit


internal final class KeyboardTextInputTraitsObserver: NSObject {
    internal typealias Handler = (UITextInputTraits) -> Void

    private var handler: Handler
    private var previousKeyboardAppearance: UIKeyboardAppearance!

    private var pollingTimer: CADisplayLink?

    internal init(handler: Handler) {
        self.handler = handler
        super.init()

        self.enable()
    }

    internal func disable() {
        self.pollingTimer?.invalidate()
        self.pollingTimer = nil
    }

    internal func enable() {
        self.disable()
        self.pollingTimer = UIScreen.mainScreen().displayLinkWithTarget(self, selector: "poll")
        self.pollingTimer?.addToRunLoop(NSRunLoop.currentRunLoop(), forMode: NSDefaultRunLoopMode)
    }

    dynamic public func poll() {
        guard let sharedInputViewController = UIInputViewController.rootInputViewController else {
            return
        }

        let textInputTraits = sharedInputViewController.textDocumentProxy as UITextInputTraits

        if self.previousKeyboardAppearance != nil {
            if self.previousKeyboardAppearance == textInputTraits.keyboardAppearance {
                return
            }
        }

        self.previousKeyboardAppearance = textInputTraits.keyboardAppearance

        self.handler(textInputTraits)
    }
}
