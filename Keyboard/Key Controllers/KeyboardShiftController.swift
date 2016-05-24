//
//  KeyboardPagesController.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 1/26/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation


internal final class KeyboardShiftController: KeyboardKeyListenerProtocol {

    internal func keyViewDidSendEvent(keyEvent: KeyboardKeyEvent) {
        let controlEvents = keyEvent.controlEvents
        let key = keyEvent.key
        let keyboardViewController = keyEvent.keyboardViewController

        if
            key.type == .Shift &&
            controlEvents == .TouchDown
        {
            keyboardViewController.keyboardMode.shiftMode.toggle()
            return
        }

        if
            key.type == .Shift &&
            controlEvents == .TouchDownRepeat
        {
            keyboardViewController.keyboardMode.shiftMode.toggleLock()
            return
        }

        if
            controlEvents == .TouchUpInside &&
            keyboardViewController.keyboardMode.shiftMode == .Enabled &&

            // TODO: Rethink: This is not universal workaround.
            key.type != .Shift &&
            key.type != .Space &&
            key.type != .Return &&
            key.type != .AdvanceToNextInputMode &&
            key.type != .Backspace
        {
            keyboardViewController.keyboardMode.shiftMode = .Disabled
        }
    }
    
}
