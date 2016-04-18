//
//  spanishKeyboardLayout.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 3/31/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation


public let spanishKeyboardLayout: KeyboardLayout = {
    var keyboardLayout = qwertyKeyboardLayout
    keyboardLayout.language = "es"

    keyboardLayout.pages[0].rows[2].insert(KeyboardKey(character: "ñ"), atIndex: keyboardLayout.pages[0].rows[2].count - 1)

    return keyboardLayout
} ()
