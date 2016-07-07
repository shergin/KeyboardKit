//
//  arabicKeyboardLayout.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 1/27/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation


public let arabicKeyboardLayout: KeyboardLayout = {
    var keyboard = KeyboardLayout()
    keyboard.type = .Other
    keyboard.language = "ar"

    func lettersKeyboardPage() -> KeyboardPage {
        var page = KeyboardPage()

        let pageCharacters: [[Character]] = [
            ["\u{0636}", "\u{0635}", "\u{062B}", "\u{0642}", "\u{0641}", "\u{063A}", "\u{0639}", "\u{0647}", "\u{062E}", "\u{062D}", "\u{062C}"],
            ["\u{0634}", "\u{0633}", "\u{064A}", "\u{0628}", "\u{0644}", "\u{0627}", "\u{062A}", "\u{0646}", "\u{0645}", "\u{0643}", "\u{0629}"],
            ["\u{0621}", "\u{0638}", "\u{0637}", "\u{0630}", "\u{062F}", "\u{0632}", "\u{0631}", "\u{0648}", "\u{0649}"],
        ]

        let alternateCharactersMap: [Character: [Character]] = [
            "е": ["ё", "ѣ"],
            "ь": ["ъ"],
            "р": ["₽"],
            "и": ["й"],
        ]

        for row in 0..<pageCharacters.count {
            for character in pageCharacters[row] {
                let key = KeyboardKey(character: character, alternateCharacters: alternateCharactersMap[character])
                page.appendKey(key, row: row)
            }
        }


        var xxxKey = KeyboardKey()
        xxxKey.label = KeyboardKeyLabel(unified: "\u{064B}\u{25CC}")


        page.appendKey(xxxKey, row: 2)
        page.appendKey(standardBackspaceKey, row: 2)

        var modeChangeNumbersKey = standardModeChangeNumbersKey
        modeChangeNumbersKey.label = KeyboardKeyLabel(unified: "\u{0661}\u{0662}\u{0663}")
        page.appendKey(modeChangeNumbersKey, row: 3)

        page.appendKey(standardAdvanceToNextInputModeKey, row: 3)
        page.appendKey(standardSpaceKey, row: 3)
        page.appendKey(standardReturnKey, row: 3)

        return page
    }

    keyboard.pages.append(lettersKeyboardPage())
    keyboard.pages.append(numbersKeyboardPage(/* currencySymbol: "\u{062F}.\u{0625}" */))
    keyboard.pages.append(specialKeyboardPage())

    return keyboard
} ()
