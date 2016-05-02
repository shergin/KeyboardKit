//
//  KeyboardShiftStatusController.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 4/19/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation


public final class KeyboardShiftStatusController {
    private var ignoresTextDocumentEvents: Bool = false

    private var textDocumentProxy: UITextDocumentProxy {
        return UIInputViewController.rootInputViewController.textDocumentProxy
    }

    public weak var keyboardViewController: KeyboardViewController? {
        didSet {
            self.textDocumentDidChanged()
        }
    }

    public var revertsShiftStateOnBackspace: Bool = true
    public var enablesShiftStateAtSentenceBeginning: Bool = true

    internal init() {
        KeyboardTextDocumentCoordinator.sharedInstance.addObserver(self)
    }

    private var shiftMode: KeyboardShiftMode {
        get {
            return self.keyboardViewController!.keyboardMode.shiftMode
        }
        set {
            self.keyboardViewController!.keyboardMode.shiftMode = newValue
        }
    }

    private func revertShiftStateOnBackspaceIfNeeded() {
        guard self.revertsShiftStateOnBackspace else {
            return
        }

        guard let lastCharacter = self.textDocumentProxy.documentContextBeforeInput?.utf16.last else {
            return
        }

        guard self.shiftMode != .Locked else {
            return
        }

        let isLastCharacterUppercaseLetter = NSCharacterSet.uppercaseLetterCharacterSet().characterIsMember(lastCharacter)

        self.shiftMode = isLastCharacterUppercaseLetter ? .Enabled : .Disabled
    }

    private func enableShiftStateAtSentenceBeginningIfNeeded() {
        guard self.enablesShiftStateAtSentenceBeginning else {
            return
        }

        guard self.shiftMode == .Disabled else {
            return
        }

        guard let utf16View = self.textDocumentProxy.documentContextBeforeInput?.utf16 else {
            // Case: Completely empty prefix.
            self.shiftMode = .Enabled
            return
        }

        var isEnableShift = false

        var wasWhitespaceCharacterFound = false
        var wasNewLineCharacterFound = false
        var wasEndOfSentenceCharacterFound = false

        var areAllCharactersBeforeEndOfSentenceWhitespaces = false
        for character in utf16View.reverse() {
            let isWhitespaceCharacter = cachedWhitespaceCharacterSet.characterIsMember(character)
            let isNewLineCharacter = cachedNewLineCharacterSet.characterIsMember(character)
            let isEndOfSentenceCharacter = cachedEndOfSentenceChracterSet.characterIsMember(character)

            wasWhitespaceCharacterFound = wasWhitespaceCharacterFound || isWhitespaceCharacter
            wasNewLineCharacterFound = wasNewLineCharacterFound || isNewLineCharacter
            wasEndOfSentenceCharacterFound = wasEndOfSentenceCharacterFound || isEndOfSentenceCharacter

            if !isWhitespaceCharacter && !isNewLineCharacter && !isEndOfSentenceCharacter {
                break
            }

            if
                (isEndOfSentenceCharacter && wasWhitespaceCharacterFound) ||
                isNewLineCharacter
            {
                self.shiftMode = .Enabled
                return
            }
        }
    }

    private func textDocumentDidChanged() {
        guard self.enablesShiftStateAtSentenceBeginning else {
            return
        }

        guard self.shiftMode == .Disabled else {
            return
        }

        let prefixIsEmpty = (self.textDocumentProxy.documentContextBeforeInput ?? "").isEmpty

        if prefixIsEmpty {
            self.shiftMode = .Enabled
        }
    }
}


extension KeyboardShiftStatusController: KeyboardTextDocumentObserver {

    public var observesTextDocumentEvents: Bool {
        return
            !self.ignoresTextDocumentEvents &&
            self.revertsShiftStateOnBackspace &&
            self.enablesShiftStateAtSentenceBeginning
    }

    public func keyboardTextDocumentDidInsertText(text: String) {
        guard let lastCharacter = text.utf16.last else {
            return
        }

        if NSCharacterSet.whitespaceAndNewlineCharacterSet().characterIsMember(lastCharacter) {
            self.enableShiftStateAtSentenceBeginningIfNeeded()
        }
    }

    public func keyboardTextDocumentWillDeleteBackward() {
        self.revertShiftStateOnBackspaceIfNeeded()
    }

    public func keyboardTextDocumentDidDeleteBackward() {
        self.enableShiftStateAtSentenceBeginningIfNeeded()
    }

    public func keyboardTextInputTraitsDidChange(textInputTraits: UITextInputTraits) {
        self.enableShiftStateAtSentenceBeginningIfNeeded()
    }

}
