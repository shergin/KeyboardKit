//
//  KeyboardPeriodShortcutController.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 3/7/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation


private let timeIntervalBetweenSpacesThreshold = 0.7

internal class KeyboardPeriodShortcutController: KeyboardListenerProtocol {
    var numberConsequencesSpaces: Int = 0
    var lastSpacePressedTime: NSTimeInterval?

    static let sentenceEndingSet: NSCharacterSet = {
        let characterSet = NSMutableCharacterSet.letterCharacterSet()
        characterSet.addCharactersInString("\"'`?!.")
        return characterSet
    } ()

    internal func keyViewDidSendEvents(controlEvents: UIControlEvents, keyView: KeyboardKeyView, key: KeyboardKey, keyboardMode: KeyboardMode) {
        var shouldInsertPeriod = false

        if controlEvents.contains(.TouchUpInside) {
            let now = NSDate().timeIntervalSince1970

            if key.type == .Space {
                if let lastSpacePressedTime = self.lastSpacePressedTime {
                    shouldInsertPeriod = now - lastSpacePressedTime < timeIntervalBetweenSpacesThreshold
                }

                self.lastSpacePressedTime = now
            }
            else {
                self.lastSpacePressedTime = nil
            }
        }

        if shouldInsertPeriod {
            let textDocumentProxy = UIInputViewController.rootInputViewController.textDocumentProxy

            let documentContextBeforeInput = textDocumentProxy.documentContextBeforeInput ?? ""

            guard documentContextBeforeInput.characters.count >= 3 else {
                return
            }

            let endIndex = documentContextBeforeInput.endIndex
            let lastTwoCharacters = documentContextBeforeInput.substringFromIndex(endIndex.advancedBy(-2))

            guard lastTwoCharacters == "  " else {
                return
            }

            let characterBeforeLastTwoCharacters = documentContextBeforeInput.substringWithRange(Range(start: endIndex.advancedBy(-3), end: endIndex.advancedBy(-2)))

            // It works like: `guard sentenceEndingSet.characterIsMember(characterBeforeLastTwoCharacters) else {}`.
            // More info: http://stackoverflow.com/questions/27697508/nscharacterset-characterismember-with-swifts-character-type
            guard self.dynamicType.sentenceEndingSet.characterIsMember(characterBeforeLastTwoCharacters.utf16.first!) else {
                return
            }

            textDocumentProxy.deleteBackward()
            textDocumentProxy.deleteBackward()
            textDocumentProxy.insertText(". ")
        }
    }
    
}
