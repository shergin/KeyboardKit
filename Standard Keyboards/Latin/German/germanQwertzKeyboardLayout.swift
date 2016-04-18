//
//  germanQwertzKeyboardLayout.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 3/31/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation


public let germanQwertzKeyboardLayout: KeyboardLayout = {
    var keyboardLayout = qwertzKeyboardLayout
    keyboardLayout.language = "de"
    return keyboardLayout
} ()
