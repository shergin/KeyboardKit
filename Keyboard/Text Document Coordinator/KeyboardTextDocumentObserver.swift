//
//  KeyboardTextDocumentObserver.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 2/12/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation

public protocol KeyboardTextDocumentObserver {
    func keyboardTextDocumentWillInsertText(text: String)
    func keyboardTextDocumentDidInsertText(text: String)

    func keyboardTextDocumentWillDeleteBackward()
    func keyboardTextDocumentDidDeleteBackward()

    func keyboardTextInputTraitsDidChange(textInputTraits: UITextInputTraits)
}

// # Making these methods optional
extension KeyboardTextDocumentObserver {
    public func keyboardTextDocumentWillInsertText(text: String) {}
    public func keyboardTextDocumentDidInsertText(text: String) {}

    public func keyboardTextDocumentWillDeleteBackward() {}
    public func keyboardTextDocumentDidDeleteBackward() {}

    public func keyboardTextInputTraitsDidChange(textInputTraits: UITextInputTraits) {}
}
