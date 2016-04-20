//
//  KeyboardShiftStatusManager.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 4/19/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation


class KeyboardShiftStatusManager {
    private var ignoreTextDocumentEvents: Bool = false

    private var textDocumentProxy: UITextDocumentProxy {
        return UIInputViewController.rootInputViewController.textDocumentProxy
    }

    public weak var keyboardViewController: KeyboardViewController? {
        didSet {
            self.textDocumentDidChanged()
        }
    }

    init() {
        KeyboardTextDocumentCoordinator.sharedInstance.addObserver(self)
    }

    var shiftMode: KeyboardShiftMode {
        get {
            return self.keyboardViewController!.keyboardMode.shiftMode
        }
        set {
            self.keyboardViewController!.keyboardMode.shiftMode = newValue
        }
    }

    func willDeleteBackward() {
        guard let lastCharacter = self.textDocumentProxy.documentContextBeforeInput?.utf16.last else {
            return
        }

        guard self.shiftMode != .Locked else {
            return
        }

        let isLastCharacterUppercaseLetter = NSCharacterSet.uppercaseLetterCharacterSet().characterIsMember(lastCharacter)

        self.shiftMode = isLastCharacterUppercaseLetter ? .Enabled : .Disabled
    }

    func whitespaceDidBeInsertedInTextDocument() {
        guard self.shiftMode != .Locked else {
            return
        }

        guard let utf16View = self.textDocumentProxy.documentContextBeforeInput?.utf16 else {
            return
        }

        guard utf16View.count > 3 else {
            return
        }

        let secondLastCharacter = utf16View[utf16View.endIndex.advancedBy(-2)]
        let thirdLastCharacter = utf16View[utf16View.endIndex.advancedBy(-3)]

        if
            NSCharacterSet.alphanumericCharacterSet().characterIsMember(thirdLastCharacter) &&
            NSCharacterSet(charactersInString: ".?!").characterIsMember(secondLastCharacter)
        {
            self.shiftMode = .Enabled
        }
    }

    func textDocumentDidChanged() {
        guard self.shiftMode == .Disabled else {
            return
        }

        let prefixIsEmpty = (self.textDocumentProxy.documentContextBeforeInput ?? "").isEmpty

        if prefixIsEmpty {
            self.shiftMode = .Enabled
        }
    }
}


extension KeyboardShiftStatusManager: KeyboardTextDocumentObserver {

    public func keyboardTextDocumentDidInsertText(text: String) {
        guard !self.ignoreTextDocumentEvents else {
            return
        }

        guard let lastCharacter = text.utf16.last else {
            return
        }

        if self.shiftMode != .Locked {
            self.shiftMode = .Disabled
        }

        if NSCharacterSet.whitespaceAndNewlineCharacterSet().characterIsMember(lastCharacter) {
            self.whitespaceDidBeInsertedInTextDocument()
        }
    }

    public func keyboardTextDocumentWillDeleteBackward() {
        guard !self.ignoreTextDocumentEvents else {
            return
        }

        self.willDeleteBackward()
    }

    public func keyboardTextInputTraitsDidChange(textInputTraits: UITextInputTraits) {
        self.textDocumentDidChanged()
    }

}
