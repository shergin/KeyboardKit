//
//  KeyboardColorMode.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 1/15/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import UIKit

public enum KeyboardColorMode: Int {
    case Light
    case Dark
}


extension KeyboardColorMode {
    public init(keyboardAppearance: UIKeyboardAppearance) {
        self = keyboardAppearance == .Dark ? .Dark : .Light
    }

    public static func suitable() -> KeyboardColorMode {
        return KeyboardColorMode(keyboardAppearance: UIInputViewController.rootInputViewController.textDocumentProxy.keyboardAppearance!)
    }
}
