//
//  KeyboardKeyEvent.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 3/17/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation

public struct KeyboardKeyEvent {
    public let controlEvents: UIControlEvents
    public let event: UIEvent
    public let key: KeyboardKey
    public let keyView: KeyboardKeyView
    public let keyboardMode: KeyboardMode
    public let keyboardViewController: KeyboardViewController
}
