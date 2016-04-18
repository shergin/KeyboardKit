//
//  KeyboardEmojis.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 2/18/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation

public final class KeyboardEmojis {

    public private(set) var emojisByCategory: [KeyboardEmojiCategory: [KeyboardEmoji]] = [:]
    public private(set) var emojis = predefinedEmojis
    public private(set) var categories: [KeyboardEmojiCategory] = KeyboardEmojiCategory.all

    static let sharedInstance = KeyboardEmojis()

    private init() {
        self.categorize()
    }

    private func categorize() {
        for emoji in self.emojis {
            guard let category = emoji.category else {
                continue
            }

            if self.emojisByCategory[category] == nil {
                self.emojisByCategory[category] = []
            }

            self.emojisByCategory[category]!.append(emoji)
        }
    }

}