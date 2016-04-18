//
//  klingonKeyboardLayout.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 3/17/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation


public let klingonKeyboardLayout: KeyboardLayout = {
    var keyboard = KeyboardLayout()
    keyboard.language = "tlh"

    func lettersKeyboardPage() -> KeyboardPage {
        var page = KeyboardPage()

        let pageCharacters: [[Character]] = [
            ["", "", "", "", "", "", "", "", "", ""],
            ["", "", "", "", "", "", "", "", ""],
            ["", "", "", "", "", "", ""],
        ]

        let alternateCharactersMap: [Character: [Character]] = [
            "": [""],
            "": [""],
            "": [""],
        ]

        for row in 0..<pageCharacters.count {
            for character in pageCharacters[row] {
                let key = KeyboardKey(character: character, alternateCharacters: alternateCharactersMap[character])
                page.appendKey(key, row: row)
            }
        }

        //page.prependKey(standardShiftKey, row: 2)
        page.appendKey(standardBackspaceKey, row: 2)

        var modeChangeNumbersKey = standardModeChangeNumbersKey
        modeChangeNumbersKey.label = KeyboardKeyLabel(unified: "")
        page.appendKey(modeChangeNumbersKey, row: 3)

        page.appendKey(standardAdvanceToNextInputModeKey, row: 3)
        page.appendKey(standardSpaceKey, row: 3)
        page.appendKey(standardReturnKey, row: 3)

        return page
    }

    keyboard.pages.append(lettersKeyboardPage())
    keyboard.pages.append(numbersKeyboardPage(currencySymbol: "", numbers: ["", "", "", "", "", "", "", "", "", ""]))
    keyboard.pages.append(specialKeyboardPage())
    
    return keyboard
} ()
