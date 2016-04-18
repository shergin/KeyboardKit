//
//  KeyboardSoundController.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 3/7/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import UIKit
import AudioToolbox


internal final class KeyboardSoundController: KeyboardListenerProtocol {

    internal func keyViewDidSendEvents(controlEvents: UIControlEvents, keyView: KeyboardKeyView, key: KeyboardKey, keyboardMode: KeyboardMode) {
        if controlEvents.contains(.TouchDown) {
            KeyboardSoundService.playInputSound()
        }
        else if controlEvents == .TouchDragEnter {
            KeyboardSoundService.playInputSound()
        }
    }
    
}


internal final class KeyboardSoundService {

    static let queue = dispatch_queue_create("com.keyboard-kit.sounds", DISPATCH_QUEUE_SERIAL)

    static var isTapticEngineAvailable: Bool = {
        if #available(iOS 9.0, *) {
            return UIInputViewController.rootInputViewController.traitCollection.forceTouchCapability == .Available
        }

        return false
    } ()

    static var inputSoundId: SystemSoundID = {
        return isTapticEngineAvailable ? 1519 : 1104
    } ()

    static func playInputSound() {
        self.playSoundWithId(self.inputSoundId)
    }

    static func playAlternateInputSound() {
        self.playSoundWithId(1521)
    }

    static var queueLength: Int = 0
    static var maxQueueLength: Int = 2

    static func playSoundWithId(soundId: SystemSoundID) {
        if self.queueLength >= self.maxQueueLength {
            return
        }

        self.queueLength += 1

        dispatch_async(self.queue) {
            if #available(iOS 9.0, *) {
                let semaphore = dispatch_semaphore_create(0)
                AudioServicesPlaySystemSoundWithCompletion(soundId) {
                    dispatch_semaphore_signal(semaphore)
                }
                dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)
            }
            else {
                AudioServicesPlaySystemSound(soundId)
            }

            dispatch_async(dispatch_get_main_queue()) {
                self.queueLength -= 1
            }
        }
    }

}