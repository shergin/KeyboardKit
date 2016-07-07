//
//  commonStandardKeyboardKeys.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 3/4/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation


public let standardSpaceKey: KeyboardKey = {
    var key = KeyboardKey(type: .Space)
    key.label = KeyboardKeyLabel(unified: "Space")
    key.output = KeyboardKeyOutput(unified: " ")
    return key
} ()


public let standardShiftKey: KeyboardKey = {
    var key = KeyboardKey(type: .Shift)
    return key
} ()


public let standardReturnKey: KeyboardKey = {
    var key = KeyboardKey(type: .Return)
    key.label = KeyboardKeyLabel(unified: "Return")
    return key
} ()


public let standardModeChangeLettersKey: KeyboardKey = {
    var key = KeyboardKey(type: .PageChange(pageNumber: 0))
    key.label = KeyboardKeyLabel(unified: "abc")
    return key
} ()


public let standardModeChangeNumbersKey: KeyboardKey = {
    var key = KeyboardKey(type: .PageChange(pageNumber: 1))
    key.label = KeyboardKeyLabel(unified: "123")
    return key
} ()


public let standardModeChangeSpecialKey: KeyboardKey = {
    var key = KeyboardKey(type: .PageChange(pageNumber: 2))
    key.label = KeyboardKeyLabel(unified: "#+=")
    return key
} ()


public let standardAdvanceToNextInputModeKey: KeyboardKey = {
    var key = KeyboardKey(type: .AdvanceToNextInputMode)
    return key
} ()


public let standardBackspaceKey: KeyboardKey = {
    var key = KeyboardKey(type: .Backspace)
    return key
} ()
