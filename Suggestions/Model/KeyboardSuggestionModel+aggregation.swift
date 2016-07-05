//
//  KeyboardSuggestionModel+aggregation.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 6/15/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation


extension KeyboardSuggestionModel {

    public func generateGuesses(query: KeyboardSuggestionQuery, callback: ([KeyboardSuggestionGuess]) -> ()) {
        var results: (spellingGuesses: [KeyboardSuggestionGuess]?, emojiGuesses: [KeyboardSuggestionGuess]?) = (spellingGuesses: nil, emojiGuesses: nil)

        let processResults = { [weak self] in
            guard
                let spellingGuesses = results.spellingGuesses,
                let emojiGuesses = results.emojiGuesses,
                let strongSelf = self
            else {
                return
            }

            var guesses: [KeyboardSuggestionGuess] = []
            guesses.appendContentsOf(spellingGuesses)
            guesses.appendContentsOf(emojiGuesses)

            callback(strongSelf.reduceGuesses(guesses))
        }

        if self.shouldSuggestSpelling() {
            self.spellingSuggestionSource.suggest(query) { guesses in
                results.spellingGuesses = guesses
                processResults()
            }
        }
        else {
            results.spellingGuesses = []
        }

        if self.shouldSuggestEmoji() {
            self.emojiSuggestionSource.suggest(query) { guesses in
                results.emojiGuesses = guesses
                processResults()
            }
        }
        else {
            results.emojiGuesses = []
        }

        processResults()
    }

    private func reduceGuesses(guesses: [KeyboardSuggestionGuess]) -> [KeyboardSuggestionGuess] {
        let autocapitalizeSpelling = self.shouldCapitalizeSpelling()
        let autocorrectSpelling = self.shouldСorrectSpelling()
        let autocompleteSpelling = autocorrectSpelling // Here it is different things but conseptualy their similar.

        let autoSpelling = autocapitalizeSpelling || autocorrectSpelling || autocompleteSpelling

        var correctionsLimit = 2
        var completionsLimit = 3
        var totalSpellingLimit = 3

        var emojisLimit = 3

        var reduceGuesses = guesses.filter { (guess: KeyboardSuggestionGuess) -> Bool in
            switch guess.type {
            case .Learning, .Autoreplacement, .Capitalization, .Prediction, .Other:
                return true
            case .Correction:
                if correctionsLimit > 0 && totalSpellingLimit > 0 {
                    correctionsLimit -= 1
                    totalSpellingLimit -= 1
                    return true
                }
            case .Completion:
                if completionsLimit > 0 && totalSpellingLimit > 0 {
                    completionsLimit -= 1
                    totalSpellingLimit -= 1
                    return true
                }
            case .Emoji:
                if emojisLimit > 0 {
                    emojisLimit -= 1
                    return true
                }
            }

            return false
        }


        var automated = !autoSpelling
        var hasAutomatedGuess = false

        reduceGuesses = reduceGuesses.map { guess in
            guard guess.automatic else {
                return guess
            }

            if
                automated ||
                (guess.type == .Correction && !autocorrectSpelling) ||
                (guess.type == .Completion && !autocompleteSpelling) ||
                (guess.type == .Capitalization && !autocapitalizeSpelling)
            {
                return guess.deautomated()
            }

            hasAutomatedGuess = true
            automated = true
            return guess
        }

        if !hasAutomatedGuess {
            reduceGuesses = reduceGuesses.filter { $0.type != .Learning }
        }

        return reduceGuesses
    }

}
