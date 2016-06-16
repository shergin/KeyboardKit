//
//  KeyboardTextDocumentCoordinator.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 2/12/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation


private var dispatchOnceToken: dispatch_once_t = 0

private var enablesNotifications = true
private var enablesDefaultBehaviour = true

private var textDocumentWillInsertText: ((text: String) -> Void)?
private var textDocumentDidInsertText: ((text: String) -> Void)?
private var textDocumentWillDeleteBackward: (() -> Void)?
private var textDocumentDidDeleteBackward: (() -> Void)?

private var textWillChange: (() -> Void)?
private var textDidChange: (() -> Void)?


extension UITextDocumentProxy {

    public func performWithoutNotifications(block: () -> Void) {
        enablesNotifications = false
        block()
        enablesNotifications = true

        textWillChange?()
        textDidChange?()
    }

}


public final class KeyboardTextDocumentCoordinator {
    private var observers = WeakSet<KeyboardTextDocumentObserver>()
    private weak var inputViewController: UIInputViewController?
    private var textInputTraitsObserver: KeyboardTextInputTraitsObserver!

    public static var sharedInstance: KeyboardTextDocumentCoordinator = {
        return KeyboardTextDocumentCoordinator(inputViewController: UIInputViewController.rootInputViewController)
    } ()

    private init(inputViewController: UIInputViewController) {
        self.inputViewController = inputViewController

        self.textInputTraitsObserver = KeyboardTextInputTraitsObserver(handler: { [unowned self] textInputTraits in
            for observer in self.observers {
                guard observer.observesTextDocumentEvents else { continue }
                observer.keyboardTextInputTraitsDidChange(textInputTraits)
            }
        })

        self.swizzleAll()
    }

    // # Public

    public func addObserver(observer: KeyboardTextDocumentObserver) {
        self.observers.insert(observer)
    }

    public func removeObserver(observer: KeyboardTextDocumentObserver) {
        self.observers.remove(observer)
    }

    public func performWithoutNotifications(block: () -> Void) {
        enablesNotifications = false
        block()
        enablesNotifications = true
    }

    // # Dispatch

    // keyboardTextDocument(Will/Did)InsertText()
    internal func dispatchKeyboardTextDocumentWillInsertText(text: String) {
        log("keyboardTextDocumentWillInsertText(\"\(text)\")")
        for observer in self.observers {
            guard observer.observesTextDocumentEvents else { continue }
            observer.keyboardTextDocumentWillInsertText(text)
        }
    }
    
    internal func dispatchKeyboardTextDocumentDidInsertText(text: String) {
        log("keyboardTextDocumentDidInsertText(\"\(text)\")")
        for observer in self.observers {
            guard observer.observesTextDocumentEvents else { continue }
            observer.keyboardTextDocumentDidInsertText(text)
        }
    }
    
    // keyboardTextDocument(Will/Did)DeleteBackward()
    internal func dispatchTextDocumentWillDeleteBackward() {
        log("dispatchTextDocumentWillDeleteBackward()")
        for observer in self.observers {
            guard observer.observesTextDocumentEvents else { continue }
            observer.keyboardTextDocumentWillDeleteBackward()
        }
    }

    internal func dispatchTextDocumentDidDeleteBackward() {
        log("dispatchTextDocumentDidDeleteBackward()")
        for observer in self.observers {
            guard observer.observesTextDocumentEvents else { continue }
            observer.keyboardTextDocumentDidDeleteBackward()
        }
    }

    // keyboardText(Will/Did)Change()
    internal func dispatchTextWillChange() {
        log("dispatchTextWillChange()")
        for observer in self.observers {
            guard observer.observesTextDocumentEvents else { continue }
            observer.keyboardTextDocumentWillChange()
        }
    }

    internal func dispatchTextDidChange() {
        log("dispatchTextDidChange()")
        for observer in self.observers {
            guard observer.observesTextDocumentEvents else { continue }
            observer.keyboardTextDocumentDidChange()
        }
    }

    // # Private

    private func swizzleAll() {
        guard
            let inputViewController = self.inputViewController,
            let textDocumentProxy = self.inputViewController?.textDocumentProxy else
        {
            return
        }

        dispatch_once(&dispatchOnceToken) {
            self.swizzleInsertText(textDocumentProxy)
            self.swizzleDeleteBackward(textDocumentProxy)

            self.swizzleTextWillChange(inputViewController)
            self.swizzleTextDidChange(inputViewController)
        }
    }

    private func swizzleInsertText(textDocumentProxy: UITextDocumentProxy) {

        textDocumentWillInsertText = { [unowned self] text in
            guard enablesNotifications else { return }
            self.dispatchKeyboardTextDocumentWillInsertText(text)
        }

        textDocumentDidInsertText = { [unowned self] text in
            guard enablesNotifications else { return }
            self.dispatchKeyboardTextDocumentDidInsertText(text)
        }

        let type = textDocumentProxy.dynamicType
        let originalMethod = class_getInstanceMethod(type, Selector("insertText:"))

        let swizzledImplementation: @convention(c) (NSObject, Selector, String) -> Void = { (_self, _cmd, text) in
            textDocumentWillInsertText?(text: text)
            _self.performSelector("originalInsertText:", withObject: text)
            textDocumentDidInsertText?(text: text)
        }

        let originalImplementation =
            method_setImplementation(
                originalMethod,
                unsafeBitCast(swizzledImplementation, IMP.self)
            )

        class_addMethod(
            type,
            "originalInsertText:",
            originalImplementation,
            method_getTypeEncoding(originalMethod)
        )
    }

    private func swizzleDeleteBackward(textDocumentProxy: UITextDocumentProxy) {

        textDocumentWillDeleteBackward = { [unowned self] in
            guard enablesNotifications else { return }
            self.dispatchTextDocumentWillDeleteBackward()
        }

        textDocumentDidDeleteBackward = { [unowned self] in
            guard enablesNotifications else { return }
            self.dispatchTextDocumentDidDeleteBackward()
        }

        let type = textDocumentProxy.dynamicType
        let originalMethod = class_getInstanceMethod(type, Selector("deleteBackward"))

        let swizzledImplementation: @convention(c) (NSObject, Selector) -> Void = { (_self, _cmd) in
            textDocumentWillDeleteBackward?()
            _self.performSelector("originalDeleteBackward")
            textDocumentDidDeleteBackward?()
        }

        let originalImplementation =
            method_setImplementation(
                originalMethod,
                unsafeBitCast(swizzledImplementation, IMP.self)
            )

        class_addMethod(
            type,
            "originalDeleteBackward",
            originalImplementation,
            method_getTypeEncoding(originalMethod)
        )
    }

    private func swizzleTextWillChange(inputViewController: UIInputViewController) {

        textWillChange = { [unowned self] in
            guard enablesNotifications else { return }
            self.dispatchTextWillChange()
        }

        let type = inputViewController.dynamicType
        let originalMethod = class_getInstanceMethod(type, Selector("textWillChange:"))

        let swizzledImplementation: @convention(c) (NSObject, Selector, AnyObject) -> Void = { (_self, _cmd, textInput) in
            _self.performSelector(Selector("originalTextWillChange:"), withObject: textInput)
            textWillChange?()
        }

        let originalImplementation =
            method_setImplementation(
                originalMethod,
                unsafeBitCast(swizzledImplementation, IMP.self)
        )

        class_addMethod(
            type,
            Selector("originalTextWillChange:"),
            originalImplementation,
            method_getTypeEncoding(originalMethod)
        )
    }

    private func swizzleTextDidChange(inputViewController: UIInputViewController) {

        textDidChange = { [unowned self] in
            guard enablesNotifications else { return }
            self.dispatchTextDidChange()
        }

        let type = inputViewController.dynamicType
        let originalMethod = class_getInstanceMethod(type, Selector("textDidChange:"))

        let swizzledImplementation: @convention(c) (NSObject, Selector, AnyObject) -> Void = { (_self, _cmd, textInput) in
            _self.performSelector(Selector("originalTextDidChange:"), withObject: textInput)
            textDidChange?()
        }

        let originalImplementation =
            method_setImplementation(
                originalMethod,
                unsafeBitCast(swizzledImplementation, IMP.self)
            )

        class_addMethod(
            type,
            Selector("originalTextDidChange:"),
            originalImplementation,
            method_getTypeEncoding(originalMethod)
        )
    }
}
