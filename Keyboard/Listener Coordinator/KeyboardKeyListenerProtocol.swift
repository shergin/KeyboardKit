//
//  KeyboardKeyListenerProtocol.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 3/17/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation


private var waitTimerToken: Int = 0
private let longWaitTimerInterval: NSTimeInterval = 0.2
private let veryLongwaitTimerInterval: NSTimeInterval = 1.5


extension UIControlEvents {
    public static var TouchDownLong: UIControlEvents = UIControlEvents(rawValue: 0x04000000)
    public static var TouchDownVeryLong: UIControlEvents = UIControlEvents(rawValue: 0x08000000)
}


public protocol KeyboardListenerProtocol: class {
    func keyViewDidSendEvent(event: KeyboardKeyEvent)
    // Temporary!
    func keyViewDidSendEvents(controlEvents: UIControlEvents, keyView: KeyboardKeyView, key: KeyboardKey, keyboardMode: KeyboardMode)
}


extension KeyboardListenerProtocol {

    // Temporary!
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

            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(longWaitTimerInterval * NSTimeInterval(NSEC_PER_SEC))), dispatch_get_main_queue()) { [weak self] in
                guard capturedWaitTimerCounter == self?.waitTimerCounter else {
                    return
                }

                self?.keyViewDidSendEvent(
                    KeyboardKeyEvent(
                        controlEvents: .TouchDownLong,//capturedEvent.controlEvents.union(.TouchDownLong),
                        event: capturedEvent.event,
                        key: capturedEvent.key,
                        keyView: capturedEvent.keyView,
                        keyboardMode: capturedEvent.keyboardMode,
                        keyboardViewController: capturedEvent.keyboardViewController
                    )
                )
            }

            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(veryLongwaitTimerInterval * NSTimeInterval(NSEC_PER_SEC))), dispatch_get_main_queue()) { [weak self] in
                guard capturedWaitTimerCounter == self?.waitTimerCounter else {
                    return
                }

                dispatch_async(dispatch_get_main_queue(), { [weak self] in
                    self?.keyViewDidSendEvent(
                        KeyboardKeyEvent(
                            controlEvents: .TouchDownVeryLong, //capturedEvent.controlEvents.union(.TouchDownVeryLong),
                            event: capturedEvent.event,
                            key: capturedEvent.key,
                            keyView: capturedEvent.keyView,
                            keyboardMode: capturedEvent.keyboardMode,
                            keyboardViewController: capturedEvent.keyboardViewController
                        )
                    )
                    })
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
