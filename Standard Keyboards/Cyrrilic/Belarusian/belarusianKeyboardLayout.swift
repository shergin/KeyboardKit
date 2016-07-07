//
//  belarusianKeyboardLayout.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 7/7/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation


public let belarusianKeyboardLayout: KeyboardLayout = {
    var keyboardLayout = jcukenKeyboardLayout
    keyboardLayout.language = "be"

    keyboardLayout.pages[0].rows[2][5] = KeyboardKey(character: "і", alternateCharacters: ["и", "ї"])
    keyboardLayout.pages[0].rows[0][8] = KeyboardKey(character: "ў", alternateCharacters: ["у"])

    return keyboardLayout
} ()
