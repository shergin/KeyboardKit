//
//  KeyboardSuggestionComplitionsSortingModel.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 6/16/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation


internal final class KeyboardSuggestionComplitionsSortingModel {

    typealias Score = Int

    private static func generateTopWordsSet(language: String) -> [String: Score] {
        var score = 1
        let words = topAmericanEnglishWords.componentsSeparatedByString(",")
        var topWords: [String: Int] = [:]
        for word in words {
            topWords[word] = score
            score += 1
        }

        return topWords
    }

    let topWords: [String: Score] = KeyboardSuggestionComplitionsSortingModel.generateTopWordsSet("en")

    init () {
    }

    internal func completions(query: KeyboardSuggestionQuery) -> [String] {
        guard query.language == "en" else {
            return []
        }

        let prefix = query.placement.trim()
        let lowercasePrefix = prefix.lowercaseString

        let prefixLength = prefix.characters.count
        var words: [String] = []
        for (word, _) in self.topWords {
            if word.hasPrefix(lowercasePrefix) {
                guard word.characters.count > prefixLength else {
                    continue
                }

                words.append(prefix + word.substringFromIndex(word.startIndex.advancedBy(prefixLength)))
            }
        }

        // Generalize to all completion sources
        if prefixLength > 1 && prefix == prefix.uppercaseString {
            words = words.map { $0.uppercaseString }
        }

        return words
    }

    internal func sortReplacements(replacements: [String], query: KeyboardSuggestionQuery) -> [String] {
        guard query.language == "en" else {
            return replacements
        }

        let topWords = self.topWords

        var scoredReplacements = replacements.map { replacement -> (replacement: String, score: Score) in
            return (
                replacement: replacement,
                score: topWords[replacement.lowercaseString] ?? (10000 + replacement.characters.count * 10)
            )
        }

        scoredReplacements.sortInPlace { (left, right) -> Bool in
            left.score < right.score
        }

        return scoredReplacements.map { $0.replacement }
    }

    internal func removeObviousReplacements(replacements: [String], query: KeyboardSuggestionQuery) -> [String] {
        let placementLength = query.placement.trim().characters.count
        return replacements.filter { $0.characters.count > placementLength }
    }
}
