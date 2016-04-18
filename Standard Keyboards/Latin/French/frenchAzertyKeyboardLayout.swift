//
//  frenchAzertyKeyboardLayout.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 3/31/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation


public let frenchAzertyKeyboardLayout: KeyboardLayout = {
    var keyboardLayout = azertyKeyboardLayout
    keyboardLayout.language = "fr"
    return keyboardLayout
} ()
