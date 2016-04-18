//
//  jcukenKeyboardLayout.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 3/31/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation


public let jcukenKeyboardLayout: KeyboardLayout = {
    var keyboardLayout = KeyboardLayout()
    keyboardLayout.type = .JCUKEN
    keyboardLayout.language = "ru"

    func lettersKeyboardPage() -> KeyboardPage {
        var page = KeyboardPage()

        let pageCharacters: [[Character]] = [
            ["й", "ц", "у", "к", "е", "н", "г", "ш", "щ", "з", "х"],
            ["ф", "ы", "в", "а", "п", "р", "о", "л", "д", "ж", "э"],
            ["я", "ч", "с", "м", "и", "т", "ь", "б", "ю"],
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

        page.prependKey(standardShiftKey, row: 2)
        page.appendKey(standardBackspaceKey, row: 2)

        page.appendKey(standardModeChangeNumbersKey, row: 3)
        page.appendKey(standardAdvanceToNextInputModeKey, row: 3)
        page.appendKey(standardSpaceKey, row: 3)
        page.appendKey(standardReturnKey, row: 3)

        return page
    }

    keyboardLayout.pages.append(lettersKeyboardPage())
    keyboardLayout.pages.append(numbersKeyboardPage(currencySymbol: "₽"))
    keyboardLayout.pages.append(specialKeyboardPage())
    
    return keyboardLayout
} ()
