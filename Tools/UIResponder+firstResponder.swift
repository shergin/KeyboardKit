//
//  UIResponder+firstResponder.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 2/5/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import UIKit

private weak var currentFirstResponder: UIResponder?

extension UIResponder {

    static func firstResponder() -> UIResponder {
        currentFirstResponder = nil
        UIApplication.sharedKeyboardApplication().sendAction("findFirstResponder:", to: nil, from: nil, forEvent: nil)
        return currentFirstResponder!
    }

    internal func findFirstResponder(sender: AnyObject) {
        currentFirstResponder = self
    }

}
