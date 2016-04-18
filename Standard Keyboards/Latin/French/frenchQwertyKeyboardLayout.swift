//
//  frenchQwertyKeyboardLayout.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 3/31/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation


public let frenchQwertyKeyboardLayout: KeyboardLayout = {
    var keyboardLayout = qwertyKeyboardLayout
    keyboardLayout.language = "fr"
    return keyboardLayout
} ()
