//
//  ukrainianKeyboardLayout.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 7/7/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation


public let ukrainianKeyboardLayout: KeyboardLayout = {
    var keyboardLayout = jcukenKeyboardLayout
    keyboardLayout.language = "uk"

    keyboardLayout.pages[0].rows[1][1] = KeyboardKey(character: "і", alternateCharacters: ["ї"])
    keyboardLayout.pages[0].rows[1][10] = KeyboardKey(character: "є", alternateCharacters: ["э"])

    // TODO: Add currency symbol: ₴.

    return keyboardLayout
} ()
