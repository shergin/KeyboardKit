//
//  englishQwertyKeyboardLayout.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 3/31/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation


public let englishQwertyKeyboardLayout: KeyboardLayout = {
    var keyboard = KeyboardLayout()
    keyboard.language = "en"
    keyboard.type = .QWERTY

    func lettersKeyboardPage() -> KeyboardPage {
        var page = KeyboardPage()

        let pageCharacters: [[Character]] = [
            ["q", "w", "e", "r", "t", "y", "u", "i", "o", "p"],
            ["a", "s", "d", "f", "g", "h", "j", "k", "l"],
            ["z", "x", "c", "v", "b", "n", "m"],
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

    keyboard.pages.append(lettersKeyboardPage())
    keyboard.pages.append(numbersKeyboardPage(currencySymbol: "$"))
    keyboard.pages.append(specialKeyboardPage())
    
    return keyboard
} ()
