//
//  turkishKeyboardLayout.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 3/31/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation


public let turkishKeyboardLayout: KeyboardLayout = {
    var keyboardLayout = qwertyKeyboardLayout
    keyboardLayout.language = "tk"

    keyboardLayout.pages[0].rows[0][7] = KeyboardKey(character: "ı")

    keyboardLayout.pages[0].appendKey(KeyboardKey(character: "ğ"), row: 1)
    keyboardLayout.pages[0].appendKey(KeyboardKey(character: "ü"), row: 1)
    keyboardLayout.pages[0].rows[2].insert(KeyboardKey(character: "ş"), atIndex: keyboardLayout.pages[0].rows[2].count - 1)
    keyboardLayout.pages[0].rows[2].insert(KeyboardKey(character: "i"), atIndex: keyboardLayout.pages[0].rows[2].count - 1)

    return keyboardLayout
} ()
