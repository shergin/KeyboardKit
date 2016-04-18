//
//  allKeyboardLayouts.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 4/1/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation


public let allKeyboardLayouts = [
    englishKeyboardLayout,
    russianKeyboardLayout,
    arabicKeyboardLayout,
    turkishKeyboardLayout,
    germanKeyboardLayout,
    frenchKeyboardLayout,
    portugueseKeyboardLayout,
    italianKeyboardLayout,
    spanishKeyboardLayout,
    klingonKeyboardLayout,
]

public let allKeyboardLayoutsById: [String: KeyboardLayout] = {
    var keyboardLayoutsById: [String: KeyboardLayout] = [:]

    for keyboardLayout in allKeyboardLayouts {
        keyboardLayoutsById[keyboardLayout.id] = keyboardLayout
    }

    return keyboardLayoutsById
} ()
