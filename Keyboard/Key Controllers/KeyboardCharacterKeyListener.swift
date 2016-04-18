//
//  KeyboardCharacterKeyListener.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 1/14/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import UIKit


public final class KeyboardCharacterKeyListener: KeyboardListenerProtocol {
    public func keyViewDidSendEvents(controlEvents: UIControlEvents, keyView: KeyboardKeyView, key: KeyboardKey, keyboardMode: KeyboardMode) {
        guard controlEvents.contains(.TouchUpInside) else {
            return
        }

        guard key.type.isCharacterOrSomethingLikeThis else {
            return
        }

        guard let output = key.output else {
            return
        }

        let text = output.outputWithShiftMode(keyboardMode.shiftMode)
        UIInputViewController.rootInputViewController.textDocumentProxy.insertText(text)
    }
}
