//
//  KeyboardKeyListenerProtocol.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 3/17/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation


private var waitTimerToken: Int = 0
private let waitTimerInterval: NSTimeInterval = 0.5


extension UIControlEvents {
    public static var TouchDownLong: UIControlEvents = UIControlEvents(rawValue: 0x04000000)
    public static var TouchDownVeryLong: UIControlEvents = UIControlEvents(rawValue: 0x08000000)
}


public protocol KeyboardListenerProtocol: class {
    func keyViewDidSendEvent(event: KeyboardKeyEvent)
    func keyViewDidSendEvents(controlEvents: UIControlEvents, keyView: KeyboardKeyView, key: KeyboardKey, keyboardMode: KeyboardMode)
}


extension KeyboardListenerProtocol {
    public func keyViewDidSendEvent(event: KeyboardKeyEvent) {
        self.keyViewDidSendEvents(
            event.controlEvents,
            keyView: event.keyView,
            key: event.key,
            keyboardMode: event.keyboardMode
        )
    }

    public func keyViewDidSendEvents(controlEvents: UIControlEvents, keyView: KeyboardKeyView, key: KeyboardKey, keyboardMode: KeyboardMode) {}

    // # Long Tap
    private var waitTimerCounter: Int {
        get {
            return objc_getAssociatedObject(self, &waitTimerToken) as? Int ?? 0
        }
        set {
            objc_setAssociatedObject(self, &waitTimerToken, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }

    private func invalidateWaitTimer() {
        self.waitTimerCounter += 1
    }

    public func waitForLongTapEvent(event: KeyboardKeyEvent) {
        let controlEvents = event.controlEvents

        if [.TouchDown].contains(controlEvents) {
            self.invalidateWaitTimer()

            let capturedWaitTimerCounter = waitTimerCounter
            let capturedEvent = event
            let when = dispatch_time(DISPATCH_TIME_NOW, Int64(waitTimerInterval * NSTimeInterval(NSEC_PER_SEC)))
            dispatch_after(when, dispatch_get_main_queue()) { [weak self] in
                guard capturedWaitTimerCounter == self?.waitTimerCounter else {
                    return
                }

                self?.keyViewDidSendEvent(
                    KeyboardKeyEvent(
                        controlEvents: capturedEvent.controlEvents.union(.TouchDownLong),
                        event: capturedEvent.event,
                        key: capturedEvent.key,
                        keyView: capturedEvent.keyView,
                        keyboardMode: capturedEvent.keyboardMode,
                        keyboardViewController: capturedEvent.keyboardViewController
                    )
                )
            }

        }
        else if [.TouchDragExit, .TouchCancel, .TouchUpInside, .TouchUpOutside, .TouchDragOutside].contains(controlEvents) {
            self.invalidateWaitTimer()
        }
    }
}


//extension Equatable where Self : KeyboardListenerProtocol {
//}

//func ==<T: KeyboardListenerProtocol>(lhs: T, rhs: T) -> Bool {
//    return unsafeAddressOf(lhs) == unsafeAddressOf(rhs)
//}
