//
//  KeyboardEmojiCategory.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 2/18/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation


public enum KeyboardEmojiCategory {
    case None

    case People
    case Nature
    case Foods
    case Activity
    case Places
    case Objects
    case Symbols
    case Flags
}

extension KeyboardEmojiCategory {
    public static var all: [KeyboardEmojiCategory] {
        return [
            .People,
            .Nature,
            .Foods,
            .Activity,
            .Places,
            .Objects,
            .Symbols,
            .Flags
        ]
    }
}