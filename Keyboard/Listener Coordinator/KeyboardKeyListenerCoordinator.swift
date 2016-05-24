//
//  KeyboardKeyListenerCoordinator.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 1/14/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation


public final class KeyboardKeyListenerCoordinator {
    // # Private
    private var listeners = KeyboardKeyListenerSet()

    private var registeredKeyViews = Set<KeyboardKeyView>()
    private var keyEventTarget: KeyboardKeyEventTarget!
    private weak var keyboardViewController: KeyboardViewController?

    internal init(keyboardViewController: KeyboardViewController) {
        self.keyboardViewController = keyboardViewController
        self.keyEventTarget = KeyboardKeyEventTarget(listenerCoordinator: self)
    }

    // # Public

    public func addListener(listener: KeyboardKeyListenerProtocol) {
        self.listeners.addListener(listener)
    }

    public func removeListener(listener: KeyboardKeyListenerProtocol) {
        self.listeners.addListener(listener)
    }

    // # Internal

    internal func keyViewDidSendControlEvents(controlEvents: UIControlEvents, keyView: KeyboardKeyView, event: UIEvent) {
        guard let keyboardViewController = self.keyboardViewController else {
            return
        }

        let keyEvent = KeyboardKeyEvent(
            controlEvents: controlEvents,
            event: event,
            key: keyView.effectiveKey,
            keyView: keyView,
            keyboardMode: keyboardViewController.keyboardMode,
            keyboardViewController: keyboardViewController
        )

        self.listeners.keyViewDidSendEvent(keyEvent)
    }

    internal func registerKeyViews() {
        self.unregistedKeyViews()

        guard let keyViewSet = self.keyboardViewController?.keyViewSet else {
            return
        }

        for (_, keyView) in keyViewSet {
            self.keyEventTarget.registerKeyView(keyView)
            self.registeredKeyViews.insert(keyView)
        }
    }

    internal func unregistedKeyViews() {
        for keyView in self.registeredKeyViews {
            self.keyEventTarget.unregisterKeyView(keyView)
        }

        self.registeredKeyViews.removeAll()
    }

}
