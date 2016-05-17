//
//  isKeyboardExtensionEnabled.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 5/16/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation


public func isKeyboardExtensionEnabled() -> Bool {
    guard let appBundleIdentifier = NSBundle.mainBundle().bundleIdentifier else {
        fatalError("isKeyboardExtensionEnabled(): Cannot retrieve bundle identifier.")
    }

    guard let keyboards = NSUserDefaults.standardUserDefaults().dictionaryRepresentation()["AppleKeyboards"] as? [String] else {
        fatalError("isKeyboardExtensionEnabled(): Cannot access to keyboard list.")
    }

    let keyboardExtensionBundleIdentifierPrefix = appBundleIdentifier + "."
    for keyboard in keyboards {
        if keyboard.hasPrefix(keyboardExtensionBundleIdentifierPrefix) {
            return true
        }
    }

    return false
}
