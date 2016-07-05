//
//  NSCharacterSet+AdditionalSets.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 4/19/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation

internal let cachedNewLineCharacterSet = NSCharacterSet.newlineCharacterSet()
internal let cachedWhitespaceCharacterSet = NSCharacterSet.whitespaceCharacterSet()

internal let cachedLowercaseLetterCharacterSet = NSCharacterSet.lowercaseLetterCharacterSet()
internal let cachedUppercaseLetterCharacterSet = NSCharacterSet.uppercaseLetterCharacterSet()
internal let cachedLetterCharacterSet = NSCharacterSet.letterCharacterSet()
internal let cachedNonLetterCharacterSet = cachedLetterCharacterSet.invertedSet

internal let cachedSeparatorChracterSet: NSCharacterSet = {
    var characterSet = NSMutableCharacterSet()
    characterSet.formUnionWithCharacterSet(NSCharacterSet.whitespaceCharacterSet())
    characterSet.formUnionWithCharacterSet(NSCharacterSet.newlineCharacterSet())
    characterSet.formUnionWithCharacterSet(NSCharacterSet.punctuationCharacterSet())
    return characterSet
} ()

internal let cachedEndOfSentenceChracterSet: NSCharacterSet = {
    return NSCharacterSet(charactersInString: ".?!")
} ()

internal let cachedEndOfSentenceAndNewLineChracterSet: NSCharacterSet = {
    var characterSet = NSMutableCharacterSet()
    characterSet.formUnionWithCharacterSet(cachedEndOfSentenceChracterSet)
    characterSet.formUnionWithCharacterSet(cachedNewLineCharacterSet)
    return characterSet
} ()


extension NSCharacterSet {
    static func separatorChracterSet() -> NSCharacterSet {
        return cachedSeparatorChracterSet
    }

    static func endOfSentenceChracterSet() -> NSCharacterSet {
        return cachedEndOfSentenceChracterSet
    }
}