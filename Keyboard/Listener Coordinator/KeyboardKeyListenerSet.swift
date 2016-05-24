//
//  KeyboardKeyListenerSet.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 5/24/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation


public final class KeyboardKeyListenerSet: KeyboardKeyListenerProtocol {

    // TODO: Use Set instead of Array
    private var listeners = Array<KeyboardKeyListenerProtocol>()

    public init() {}

    public func addListener(listener: KeyboardKeyListenerProtocol) {
        self.listeners.append(listener)
    }

    public func removeListener(listener: KeyboardKeyListenerProtocol) {
        guard let index = self.listeners.indexOf({ $0 == listener }) else {
            fatalError("The listener not found.")
        }

        self.listeners.removeAtIndex(index)
    }

    // # KeyboardKeyListenerProtocol
    public func keyViewDidSendEvent(event: KeyboardKeyEvent) {
        for listener in self.listeners {
            listener.keyViewDidSendEvent(event)
        }
    }

}
