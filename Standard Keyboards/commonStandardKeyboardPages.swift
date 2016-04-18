//
//  commonStandardKeyboardPages.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 3/4/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation


public func specialKeyboardPage() -> KeyboardPage {
    var page = KeyboardPage()

    let pageCharacters: [[Character]] = [
        ["[", "]", "{", "}", "#", "%", "^", "*", "+", "="],
        ["_", "\\", "|", "~", "<", ">", "€", "¥", "¥", "•"],
        [".", ",", "?", "!", "`"],
    ]

    for row in 0..<pageCharacters.count {
        for character in pageCharacters[row] {
            page.appendKey(KeyboardKey(character: character), row: row)
        }
    }

    page.prependKey(standardModeChangeNumbersKey, row: 2)
    page.appendKey(standardBackspaceKey, row: 2)

    page.appendKey(standardModeChangeLettersKey, row: 3)
    page.appendKey(standardAdvanceToNextInputModeKey, row: 3)
    page.appendKey(standardSpaceKey, row: 3)
    page.appendKey(standardReturnKey, row: 3)

    return page
}


public func numbersKeyboardPage(
    currencySymbol currencySymbol: String = "$",
    numbers: [Character]? = nil
) -> KeyboardPage {
    var page = KeyboardPage()

    let pageCharacters: [[Character]] = [
        numbers ?? ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"],
        ["-", "/", ":", ";", "(", ")", Character(currencySymbol), "&", "@", "\""],
        [".", ",", "?", "!", "'"],
    ]

    let alternateCharactersMap: [Character: [Character]] = [
        "0": ["⁰", "₀"],
        "1": ["¹", "₁", "ⁱ"],
        "2": ["²", "₂"],
        "3": ["³", "₃"],
        "4": ["⁴", "₄"],
        "5": ["⁵", "₅"],
        "6": ["⁶", "₆"],
        "7": ["⁷", "₇"],
        "8": ["⁸", "₈"],
        "9": ["⁹", "₉"],

        "(": ["[", "{", "<"],
        ")": ["]", "}", ">"],

        "?": ["¿", "⁇", "⁈", "⁉", "‽"],
        "!": ["¡", "‼", "⁉", "⁈", "‽"],
        ".": ["…", "⋯"],
        "/": ["／", "∕", "⁄"],
        "-": ["—", "–", "—", "‒"],
    ]


    for row in 0..<pageCharacters.count {
        for character in pageCharacters[row] {
            let key = KeyboardKey(character: character, alternateCharacters: alternateCharactersMap[character])
            page.appendKey(key, row: row)
        }
    }

    page.prependKey(standardModeChangeSpecialKey, row: 2)
    page.appendKey(standardBackspaceKey, row: 2)

    page.appendKey(standardModeChangeLettersKey, row: 3)
    page.appendKey(standardAdvanceToNextInputModeKey, row: 3)
    page.appendKey(standardSpaceKey, row: 3)
    page.appendKey(standardReturnKey, row: 3)

    return page
}
