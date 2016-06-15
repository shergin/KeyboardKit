//
//  KeyboardBackspaceKeyController.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 3/14/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation


private let backspaceDelay = NSTimeInterval(0.5)
private let backspaceRepeat = NSTimeInterval(0.07)


public final class KeyboardBackspaceKeyController: KeyboardKeyListenerProtocol {

    private var delayTimer: NSTimer?
    private var repeatTimer: NSTimer?

    public func keyViewDidSendEvents(controlEvents: UIControlEvents, keyView: KeyboardKeyView, key: KeyboardKey, keyboardMode: KeyboardMode) {
        guard key.type == .Backspace else {
            return
        }

        if [.TouchDown].contains(controlEvents) {
            self.keyDownHandler()
        }
        else if [.TouchDragExit, .TouchCancel, .TouchUpInside, .TouchUpOutside, .TouchDragOutside].contains(controlEvents) {
            self.keyUpHandler()
        }
    }

    private func deleteBackward() {
        UIInputViewController.rootInputViewController.textDocumentProxy.deleteBackward()
    }

    private func keyDownHandler() {
        self.deleteBackward()

        self.cancelTimers()
        self.delayTimer =
            NSTimer.scheduledTimerWithTimeInterval(backspaceDelay - backspaceRepeat, target: self, selector: Selector("delayHandler"), userInfo: nil, repeats: false)
    }

    private func keyUpHandler() {
        self.cancelTimers()
    }

    private func cancelTimers() {
        self.delayTimer?.invalidate()
        self.delayTimer = nil
        self.repeatTimer?.invalidate()
        self.repeatTimer = nil
    }

    internal dynamic func delayHandler() {
        self.cancelTimers()

        self.repeatTimer =
            NSTimer.scheduledTimerWithTimeInterval(backspaceRepeat, target: self, selector: Selector("repeatHandler"), userInfo: nil, repeats: true)
    }

    internal dynamic func repeatHandler() {
        self.deleteBackward()
        KeyboardSoundService.sharedInstance.playInputSound()
    }

}
