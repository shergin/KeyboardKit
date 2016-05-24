//
//  KeyboardCommonActionKeyListener.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 1/14/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation

public final class KeyboardCommonActionKeyListener: KeyboardKeyListenerProtocol {
    public func keyViewDidSendEvents(controlEvents: UIControlEvents, keyView: KeyboardKeyView, key: KeyboardKey, keyboardMode: KeyboardMode) {

        //let isTouchDown = controlEvents.contains(.TouchDown)
        let isTouchUpInside = controlEvents.contains(.TouchUpInside)

//        if isTouchUpInside && key.type == .AdvanceToNextInputMode {
//            self.inputViewController.advanceToNextInputMode()
//            return
//        }

        if isTouchUpInside && key.type == .Return {
            UIInputViewController.rootInputViewController.textDocumentProxy.insertText("\n")
            return
        }
    }

}
