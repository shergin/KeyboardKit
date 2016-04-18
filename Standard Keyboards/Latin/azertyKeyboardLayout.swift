//
//  azertyKeyboardLayout.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 3/31/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation


public let azertyKeyboardLayout: KeyboardLayout = {
    var keyboardLayout = KeyboardLayout()
    keyboardLayout.type = .AZERTY
    keyboardLayout.language = "fr"

    func lettersKeyboardPage() -> KeyboardPage {
        var page = KeyboardPage()

        let pageCharacters: [[Character]] = [
            ["a", "z", "e", "r", "t", "y", "u", "i", "o", "p"],
            ["q", "s", "d", "f", "g", "h", "j", "k", "l", "m"],
            ["w", "x", "c", "v", "b", "n"],
        ]

        for row in 0..<pageCharacters.count {
            for character in pageCharacters[row] {
                let key = KeyboardKey(character: character, alternateCharacters: latinAlternateCharactersMap[character])
                page.appendKey(key, row: row)
            }
        }

        page.prependKey(standardShiftKey, row: 2)
        page.appendKey(standardBackspaceKey, row: 2)

        page.appendKey(standardModeChangeNumbersKey, row: 3)
        page.appendKey(standardAdvanceToNextInputModeKey, row: 3)
        page.appendKey(standardSpaceKey, row: 3)
        page.appendKey(standardReturnKey, row: 3)

        return page
    }

    keyboardLayout.pages.append(lettersKeyboardPage())
    keyboardLayout.pages.append(numbersKeyboardPage(currencySymbol: "$"))
    keyboardLayout.pages.append(specialKeyboardPage())
    
    return keyboardLayout
} ()
