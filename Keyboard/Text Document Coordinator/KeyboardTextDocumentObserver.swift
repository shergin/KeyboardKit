//
//  KeyboardTextDocumentObserver.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 2/12/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation

public protocol KeyboardTextDocumentObserver: AnyObject {
    var observesTextDocumentEvents: Bool {get}

    func keyboardTextDocumentWillInsertText(text: String)
    func keyboardTextDocumentDidInsertText(text: String)

    func keyboardTextDocumentWillDeleteBackward()
    func keyboardTextDocumentDidDeleteBackward()

    func keyboardTextDocumentWillChange()
    func keyboardTextDocumentDidChange()

    func keyboardTextInputTraitsDidChange(textInputTraits: UITextInputTraits)
}

// # Making these methods optional
extension KeyboardTextDocumentObserver {
    public var observesTextDocumentEvents: Bool {
        return true
    }

    public func keyboardTextDocumentWillInsertText(text: String) {}
    public func keyboardTextDocumentDidInsertText(text: String) {}

    public func keyboardTextDocumentWillDeleteBackward() {}
    public func keyboardTextDocumentDidDeleteBackward() {}

    public func keyboardTextDocumentWillChange() {}
    public func keyboardTextDocumentDidChange() {}

    public func keyboardTextInputTraitsDidChange(textInputTraits: UITextInputTraits) {}
}
