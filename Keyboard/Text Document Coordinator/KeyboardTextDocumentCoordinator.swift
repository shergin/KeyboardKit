//
//  KeyboardTextDocumentCoordinator.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 2/12/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation


private var dispatchOnceToken: dispatch_once_t = 0

private var textDocumentWillInsertText: ((text: String) -> Void)?
private var textDocumentDidInsertText: ((text: String) -> Void)?
private var textDocumentWillDeleteBackward: (() -> Void)?
private var textDocumentDidDeleteBackward: (() -> Void)?


public final class KeyboardTextDocumentCoordinator {
    private var observers = WeakSet<KeyboardTextDocumentObserver>()
    private var textDocumentProxy: UITextDocumentProxy
    private var textInputTraitsObserver: KeyboardTextInputTraitsObserver!

    public static var sharedInstance: KeyboardTextDocumentCoordinator = {
        return KeyboardTextDocumentCoordinator(textDocumentProxy: UIInputViewController.rootInputViewController.textDocumentProxy)
    } ()

    private init(textDocumentProxy: UITextDocumentProxy) {
        self.textDocumentProxy = textDocumentProxy

        self.textInputTraitsObserver = KeyboardTextInputTraitsObserver(handler: { [unowned self] textInputTraits in
            for observer in self.observers {
                observer.keyboardTextInputTraitsDidChange(textInputTraits)
            }
        })

        self.swizzleAll()
    }

    // # Public

    public func addObserver(observer: KeyboardTextDocumentObserver) {
        self.observers.addObject(observer)
    }

    public func removeObserver(observer: KeyboardTextDocumentObserver) {
        self.observers.removeObject(observer)
    }

    // # Private

    private func swizzleAll() {
        dispatch_once(&dispatchOnceToken) {
            self.swizzleInsertText()
            self.swizzleDeleteBackward()
        }
    }

    private func swizzleInsertText() {

        textDocumentWillInsertText = { [unowned self] text in
            //print("textDocumentWillInsertText(\(text))")
            for observer in self.observers {
                observer.keyboardTextDocumentWillInsertText(text)
            }
        }

        textDocumentDidInsertText = { [unowned self] text in
            //print("textDocumentDidInsertText(\(text))")
            for observer in self.observers {
                observer.keyboardTextDocumentDidInsertText(text)
            }
        }

        let type = self.textDocumentProxy.dynamicType
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

    private func swizzleDeleteBackward() {

        textDocumentWillDeleteBackward = { [unowned self] text in
            //print("textDocumentWillDeleteBackward()")
            for observer in self.observers {
                observer.keyboardTextDocumentWillDeleteBackward()
            }
        }

        textDocumentDidDeleteBackward = { [unowned self] text in
            //print("textDocumentDidDeleteBackward()")
            for observer in self.observers {
                observer.keyboardTextDocumentDidDeleteBackward()
            }
        }

        let type = self.textDocumentProxy.dynamicType
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

}
