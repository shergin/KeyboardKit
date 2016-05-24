//
//  KeyboardSoundController.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 3/7/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import UIKit
import AudioToolbox


internal final class KeyboardSoundController: KeyboardKeyListenerProtocol {

    internal func keyViewDidSendEvents(controlEvents: UIControlEvents, keyView: KeyboardKeyView, key: KeyboardKey, keyboardMode: KeyboardMode) {
        if controlEvents.contains(.TouchDown) {
            KeyboardSoundService.sharedInstance.playInputSound()
        }
        else if controlEvents == .TouchDragEnter {
            KeyboardSoundService.sharedInstance.playInputSound()
        }
    }
    
}


public final class KeyboardSoundService {

    public static var sharedInstance = KeyboardSoundService()

    public var enablesTapticEngine: Bool = true
    public var enablesSound: Bool = true

    private let soundQueue = dispatch_queue_create("com.keyboard-kit.sound-sound", DISPATCH_QUEUE_SERIAL)
    private let tapticQueue = dispatch_queue_create("com.keyboard-kit.taptic-feedback", DISPATCH_QUEUE_SERIAL)

    private var soundQueueLength: Int = 0
    private var soundMaxQueueLength: Int = 2

    private var tapticQueueLength: Int = 0
    private var tapticMaxQueueLength: Int = 2

    private init() {
    }

    public lazy var isTapticEngineAvailable: Bool = {
        if #available(iOS 9.0, *) {
            return UIInputViewController.rootInputViewController.traitCollection.forceTouchCapability == .Available
        }

        return false
    } ()

    public func playInputSound() {
        if self.enablesSound {
            self.playSoundWithId(1104)
        }

        if self.enablesTapticEngine && self.isTapticEngineAvailable {
            self.playTapticWithId(1519)
        }
    }

    public func playAlternateInputSound() {
        if self.enablesTapticEngine && self.isTapticEngineAvailable {
            self.playTapticWithId(1521)
        }
    }

    private func playSoundWithId(soundId: SystemSoundID, queue: dispatch_queue_t, callback: () -> Void) {
        dispatch_async(queue) {
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
                callback()
            }
        }
    }

    private func playSoundWithId(soundId: SystemSoundID) {
        if self.soundQueueLength >= self.soundMaxQueueLength {
            return
        }

        self.soundQueueLength += 1

        self.playSoundWithId(soundId, queue: self.soundQueue) {
            self.soundQueueLength -= 1
        }
    }

    private func playTapticWithId(soundId: SystemSoundID) {
        if self.tapticQueueLength >= self.tapticMaxQueueLength {
            return
        }

        self.tapticQueueLength += 1

        self.playSoundWithId(soundId, queue: self.tapticQueue) {
            self.tapticQueueLength -= 1
        }
    }

}