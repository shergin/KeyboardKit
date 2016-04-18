//
//  KeyboardEmoji.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 2/18/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation


public struct KeyboardEmoji {
    let character: String
    let name: String?
    let shortNames: [String]?
    let keywords: [String]?
    let category: KeyboardEmojiCategory?
}


extension KeyboardEmoji: Equatable {
}

public func ==(lhs: KeyboardEmoji, rhs: KeyboardEmoji) -> Bool {
    return
        lhs.character == rhs.character
}


extension KeyboardEmoji: Hashable {
    public var hashValue: Int {
        return self.character.hashValue
    }
}
