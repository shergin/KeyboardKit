//
//  KeyboardKeyPopupTypeController.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 1/18/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import UIKit


internal final class KeyboardKeyPopupTypeController: KeyboardListenerProtocol {
    let popupShowEvents: UIControlEvents = [.TouchDown, .TouchDragInside, .TouchDragEnter]
    let popupHideEvents: UIControlEvents = [.TouchDragExit, .TouchCancel]
    let popupDelayedHideEvents: UIControlEvents = [.TouchUpInside, .TouchUpOutside, .TouchDragOutside]

    internal init() {
    }

    internal func keyViewDidSendEvents(controlEvents: UIControlEvents, keyView: KeyboardKeyView, key: KeyboardKey, keyboardMode: KeyboardMode) {
        let appearance = keyView.appearance

        if key.alternateKeys != nil {
            if popupShowEvents.contains(controlEvents) {
                self.setTimeout(keyView.hashValue) {

                    KeyboardSoundService.sharedInstance.playAlternateInputSound()

                    keyView.keyMode.popupMode = .AlternateKeys
                    keyView.updateIfNeeded()
                }
            }
        }

        if popupHideEvents.contains(controlEvents) || popupDelayedHideEvents.contains(controlEvents) {
            self.clearTimeout()
        }

        if
            appearance.shouldShowPreviewPopup &&
            keyView.keyMode.popupMode == .None &&
            popupShowEvents.contains(controlEvents)
        {
            self.showPopupForKeyView(keyView)
            return
        }

        if
            keyView.keyMode.popupMode != .None &&
            popupHideEvents.contains(controlEvents)
        {
            self.hidePopupForKeyView(keyView)
            return
        }

        if
            keyView.keyMode.popupMode != .None &&
            popupDelayedHideEvents.contains(controlEvents)
        {
            let delay = 0.05
            let when = dispatch_time(DISPATCH_TIME_NOW, Int64(delay * NSTimeInterval(NSEC_PER_SEC)))
            dispatch_after(when, dispatch_get_main_queue()) { [weak self] in
                self?.hidePopupForKeyView(keyView)
            }
            return
        }

    }

    private func showPopupForKeyView(keyView: KeyboardKeyView) {
        keyView.keyMode.popupMode = .Preview
        keyView.updateIfNeeded()
    }

    private func hidePopupForKeyView(keyView: KeyboardKeyView) {
        keyView.keyMode.popupMode = .None
        keyView.updateIfNeeded()
    }

    private var timeoutToken: Int?
    func setTimeout(token: Int?, callback: () -> ()) {
        guard token != self.timeoutToken else {
            return
        }

        self.clearTimeout()

        self.timeoutToken = token

        let timeoutToken = token

        let delay = 0.7
        let when = dispatch_time(DISPATCH_TIME_NOW, Int64(delay * NSTimeInterval(NSEC_PER_SEC)))
        dispatch_after(when, dispatch_get_main_queue()) { [weak weakSelf = self] in
            guard let strongSelf = weakSelf else {
                return
            }

            guard strongSelf.timeoutToken == timeoutToken else {
                return
            }

            callback()
        }
    }

    func clearTimeout() {
        self.timeoutToken = nil
    }
}



extension UIControlEvents {
    internal static let LongPress = UIControlEvents(rawValue: 0x01000000)
    internal static let VeryLongPress = UIControlEvents(rawValue: 0x02000000)
}


extension KeyboardListenerProtocol {


    internal func handleLongPresses(controlEvents: UIControlEvents, keyView: KeyboardKeyView, key: KeyboardKey, keyboardMode: KeyboardMode) {

    }
}