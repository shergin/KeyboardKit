//
//  KeyboardEmojiSuggestionModel.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 3/7/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation


internal final class KeyboardEmojiSuggestionModel {

    static let emojiMap: [String: [KeyboardEmoji]] = {
        var map = [String: [KeyboardEmoji]]()

        func addEmoji(emoji: KeyboardEmoji, forKey key: String?) {
            guard let key = key else {
                return
            }

            if map[key] == nil {
                map[key] = []
            }

            map[key]!.append(emoji)
        }

        for emoji in predefinedEmojis {
            addEmoji(emoji, forKey: emoji.name?.lowercaseString)

            for shortname in emoji.shortNames ?? [] {
                addEmoji(emoji, forKey: shortname.lowercaseString)
            }

            for keyword in emoji.keywords ?? [] {
                addEmoji(emoji, forKey: keyword.lowercaseString)
            }
        }

        return map
    }()

    func suggestions(source: String) -> [String] {
        let emojis = self.dynamicType.emojiMap[source.lowercaseString] ?? []
        return emojis.map { $0.character }
    }
}
