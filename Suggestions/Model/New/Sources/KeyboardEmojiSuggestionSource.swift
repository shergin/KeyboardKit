//
//  KeyboardEmojiSuggestionSource.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 4/8/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation


internal final class KeyboardEmojiSuggestionSource: KeyboardSuggestionSource {

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


    func suggest(query: KeyboardSuggestionQuery, callback: KeyboardSuggestionSourceCallback) {
        let keyword = query.placement.lowercaseString.trim()

        guard !keyword.isEmpty else {
            callback([])
            return
        }

        let emojis = self.dynamicType.emojiMap[keyword] ?? []

        let guesses: [KeyboardSuggestionGuess] = emojis.map { emoji in
            var guess = KeyboardSuggestionGuess(
                query: query,
                type: .Emoji,
                replacement: emoji.character
            )

            return guess
        }

        callback(guesses)
    }

}
