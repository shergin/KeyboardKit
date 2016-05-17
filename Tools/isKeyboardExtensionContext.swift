//
//  isKeyboardExtensionContext.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 5/17/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation

public func isKeyboardExtensionContext() -> Bool {
    return UIInputViewController.isRootInputViewControllerAvailable
}
