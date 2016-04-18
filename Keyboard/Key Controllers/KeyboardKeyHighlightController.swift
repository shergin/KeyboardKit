//
//  KeyboardKeyHighlightController.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 2/24/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation


internal final class KeyboardKeyHighlightController: KeyboardListenerProtocol {

    let highlightOnEvents: UIControlEvents = [.TouchDown, .TouchDragInside, .TouchDragEnter]
    let highlightOffEvents: UIControlEvents = [.TouchDragExit, .TouchCancel, .TouchUpInside, .TouchUpOutside, .TouchDragOutside]

    internal func keyViewDidSendEvents(controlEvents: UIControlEvents, keyView: KeyboardKeyView, key: KeyboardKey, keyboardMode: KeyboardMode) {
        let appearance = keyView.appearance

        guard appearance.shouldHighlight else {
            return
        }

        if !controlEvents.intersect(highlightOnEvents).isEmpty {
            keyView.keyMode.highlightMode = .Highlighted
            keyView.updateIfNeeded()
            return
        }

        if !controlEvents.intersect(highlightOffEvents).isEmpty {
            keyView.keyMode.highlightMode = .None
            keyView.updateIfNeeded()
            return
        }
    }
    
}
