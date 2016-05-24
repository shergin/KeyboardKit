//
//  KeyboardPagesController.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 1/26/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation

internal class KeyboardPagesController: KeyboardKeyListenerProtocol {
    
    internal func keyViewDidSendEvent(keyEvent: KeyboardKeyEvent) {
        guard keyEvent.controlEvents.contains(.TouchUpInside) else {
            return
        }

        let key = keyEvent.key
        let keyboardViewController = keyEvent.keyboardViewController

        if
            keyboardViewController.pageNumber != 0 &&
            (
                (key.type == .Character && key.output?.lowercase == "'") ||
                (key.type == .Space) ||
                (key.type == .Return)
            )
        {
            keyboardViewController.pageNumber = 0
            return
        }

        if case .PageChange(let pageNumber) = key.type {
            keyboardViewController.pageNumber = pageNumber
            return
        }
    }

}
