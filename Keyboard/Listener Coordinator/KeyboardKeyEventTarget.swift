//
//  KeyboardKeyEventTarget.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 1/14/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import UIKit


internal class KeyboardKeyEventTarget: NSObject {
    private unowned var listenerCoordinator: KeyboardListenerCoordinator

    internal init(listenerCoordinator: KeyboardListenerCoordinator) {
        self.listenerCoordinator = listenerCoordinator
    }

    internal func registerKeyView(keyView: KeyboardKeyView) {
        // Reasons: http://stackoverflow.com/questions/6131549/how-can-i-determine-which-uicontrolevents-type-caused-a-uievent
        keyView.addTarget(self, action: "keyViewDidTouchDown:event:", forControlEvents: .TouchDown)
        keyView.addTarget(self, action: "keyViewDidTouchDownRepeat:event:", forControlEvents: .TouchDownRepeat)
        keyView.addTarget(self, action: "keyViewDidTouchDragInside:event:", forControlEvents: .TouchDragInside)
        keyView.addTarget(self, action: "keyViewDidTouchDragOutside:event:", forControlEvents: .TouchDragOutside)
        keyView.addTarget(self, action: "keyViewDidTouchDragEnter:event:", forControlEvents: .TouchDragEnter)
        keyView.addTarget(self, action: "keyViewDidTouchDragExit:event:", forControlEvents: .TouchDragExit)
        keyView.addTarget(self, action: "keyViewDidTouchUpInside:event:", forControlEvents: .TouchUpInside)
        keyView.addTarget(self, action: "keyViewDidTouchUpOutside:event:", forControlEvents: .TouchUpOutside)
        keyView.addTarget(self, action: "keyViewDidTouchCancel:event:", forControlEvents: .TouchCancel)
    }

    internal func unregisterKeyView(keyView: KeyboardKeyView) {
        keyView.removeTarget(self, action: nil, forControlEvents: .AllEvents)
    }

    internal func keyViewDidSendEvents(controlEvents: UIControlEvents, keyView: KeyboardKeyView, event: UIEvent) {
        self.listenerCoordinator.keyViewDidSendControlEvents(
            controlEvents,
            keyView: keyView,
            event: event
        )
    }

    // # keyViewDidTouch*'s
    internal dynamic func keyViewDidTouchDown(keyView: KeyboardKeyView, event: UIEvent) {
        self.keyViewDidSendEvents(.TouchDown, keyView: keyView, event: event)
    }

    internal dynamic func keyViewDidTouchDownRepeat(keyView: KeyboardKeyView, event: UIEvent) {
        self.keyViewDidSendEvents(.TouchDownRepeat, keyView: keyView, event: event)
    }

    internal dynamic func keyViewDidTouchDragInside(keyView: KeyboardKeyView, event: UIEvent) {
        self.keyViewDidSendEvents(.TouchDragInside, keyView: keyView, event: event)
    }

    internal dynamic func keyViewDidTouchDragOutside(keyView: KeyboardKeyView, event: UIEvent) {
        self.keyViewDidSendEvents(.TouchDragOutside, keyView: keyView, event: event)
    }

    internal dynamic func keyViewDidTouchDragEnter(keyView: KeyboardKeyView, event: UIEvent) {
        self.keyViewDidSendEvents(.TouchDragEnter, keyView: keyView, event: event)
    }

    internal dynamic func keyViewDidTouchDragExit(keyView: KeyboardKeyView, event: UIEvent) {
        self.keyViewDidSendEvents(.TouchDragExit, keyView: keyView, event: event)
    }

    internal dynamic func keyViewDidTouchUpInside(keyView: KeyboardKeyView, event: UIEvent) {
        self.keyViewDidSendEvents(.TouchUpInside, keyView: keyView, event: event)
    }

    internal dynamic func keyViewDidTouchUpOutside(keyView: KeyboardKeyView, event: UIEvent) {
        self.keyViewDidSendEvents(.TouchUpOutside, keyView: keyView, event: event)
    }

    internal dynamic func keyViewDidTouchCancel(keyView: KeyboardKeyView, event: UIEvent) {
        self.keyViewDidSendEvents(.TouchCancel, keyView: keyView, event: event)
    }

}
