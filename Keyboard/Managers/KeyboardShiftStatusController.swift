//
//  KeyboardShiftStatusController.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 4/19/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation


public final class KeyboardShiftStatusController {

    private var textDocumentProxy: UITextDocumentProxy {
        return UIInputViewController.rootInputViewController.textDocumentProxy
    }

    public weak var keyboardViewController: KeyboardViewController? {
        didSet {
            self.textDocumentDidChanged()
        }
    }

    public var revertsShiftStateOnBackspace: Bool = true {
        didSet {
            guard self.revertsShiftStateOnBackspace != oldValue else { return }
            self.resetState()
        }
    }

    public var enablesShiftStateAtSentenceBeginning: Bool = true {
        didSet {
            guard self.enablesShiftStateAtSentenceBeginning != oldValue else { return }
            self.resetState()
        }
    }

    internal init() {
        KeyboardTextDocumentCoordinator.sharedInstance.addObserver(self)
    }

    private var shiftMode: KeyboardShiftMode {
        get {
            return self.keyboardViewController?.keyboardMode.shiftMode ?? .Disabled
        }
        set {
            self.keyboardViewController?.keyboardMode.shiftMode = newValue
        }
    }

    private func resetState() {
        self.shiftMode = .Disabled
        self.toggleShiftIfNeeded()
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

        let isLastCharacterUppercaseLetter = cachedUppercaseLetterCharacterSet.characterIsMember(lastCharacter)

        self.shiftMode = isLastCharacterUppercaseLetter ? .Enabled : .Disabled
    }

    private func toggleShiftIfNeeded() {
        guard self.enablesShiftStateAtSentenceBeginning else {
            return
        }

        guard self.shiftMode != .Locked else {
            return
        }

        // # Cases:
        // # ⬆️-cases:
        //
        //  *  Abc abc. ⦚⬆️
        //  *  ↩⦚⬆️
        //
        //
        // # ⬇️-cases:
        //  *  A⦚⬇️

        var wasShiftEnable = self.shiftMode == .Enabled
        var wantsEnableShift = !wasShiftEnable
        var wantsDisableShift = wasShiftEnable

        guard let utf16View = self.textDocumentProxy.documentContextBeforeInput?.utf16 where utf16View.count > 0 else {
            // Case: Completely empty prefix.
            self.shiftMode = .Enabled
            return
        }

        var wasWhitespaceCharacterFound = false
        var wasNewLineCharacterFound = false
        var wasEndOfSentenceCharacterFound = false
        var wasUppercaseCharacterFound = false
        var wasLowercaseCharacterFound = false

        var areAllCharactersBeforeEndOfSentenceWhitespaces = false
        for character in utf16View.reverse() {
            guard wantsEnableShift || wantsDisableShift else {
                break
            }

            let isWhitespaceCharacter = cachedWhitespaceCharacterSet.characterIsMember(character)
            let isNewLineCharacter = cachedNewLineCharacterSet.characterIsMember(character)
            let isEndOfSentenceCharacter = cachedEndOfSentenceChracterSet.characterIsMember(character)
            let isLowercaseCharacter = cachedLowercaseLetterCharacterSet.characterIsMember(character)
            let isUppercaseCharacter = cachedUppercaseLetterCharacterSet.characterIsMember(character)
            let isCharacter = isLowercaseCharacter || isUppercaseCharacter

            wasWhitespaceCharacterFound = wasWhitespaceCharacterFound || isWhitespaceCharacter
            wasNewLineCharacterFound = wasNewLineCharacterFound || isNewLineCharacter
            wasEndOfSentenceCharacterFound = wasEndOfSentenceCharacterFound || isEndOfSentenceCharacter
            wasUppercaseCharacterFound = wasUppercaseCharacterFound || isUppercaseCharacter
            wasLowercaseCharacterFound = wasLowercaseCharacterFound || isLowercaseCharacter

            // # Positive cases
            if
                wantsEnableShift &&
                (
                    (isEndOfSentenceCharacter && wasWhitespaceCharacterFound) ||
                    isNewLineCharacter
                )
            {
                self.shiftMode = .Enabled
                break
            }

            if
                wantsDisableShift &&
                (
                    isCharacter
                )
            {
                self.shiftMode = .Disabled
                break
            }

            // # Stop cases
            if
                wantsEnableShift &&
                (isNewLineCharacter || isEndOfSentenceCharacter || isCharacter)
            {
                wantsEnableShift = false
            }

            if
                wantsDisableShift &&
                (isNewLineCharacter || isEndOfSentenceCharacter || isCharacter)
            {
                wantsDisableShift = false
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
            self.revertsShiftStateOnBackspace ||
            self.enablesShiftStateAtSentenceBeginning
    }

    public func keyboardTextDocumentDidInsertText(text: String) {
        guard let lastCharacter = text.utf16.last else {
            return
        }

        if NSCharacterSet.whitespaceAndNewlineCharacterSet().characterIsMember(lastCharacter) {
            self.toggleShiftIfNeeded()
        }
    }

    public func keyboardTextDocumentWillDeleteBackward() {
        self.revertShiftStateOnBackspaceIfNeeded()
    }

    public func keyboardTextDocumentDidDeleteBackward() {
        self.toggleShiftIfNeeded()
    }

    public func keyboardTextDocumentDidChange() {
        self.toggleShiftIfNeeded()
    }
}
