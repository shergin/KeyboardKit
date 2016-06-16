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

        let processResults = {
            guard
                let spellingGuesses = results.spellingGuesses,
                let emojiGuesses = results.emojiGuesses
                else {
                    return
            }

            var guesses: [KeyboardSuggestionGuess] = []
            guesses.appendContentsOf(spellingGuesses)
            guesses.appendContentsOf(emojiGuesses)

            callback(self.reduceGuesses(guesses))
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

        //
        let capitalizeSpelling = self.shouldCapitalizeSpelling()
        let correctSpelling = self.shouldСorrectSpelling()

        var automated = !correctSpelling && !capitalizeSpelling

        reduceGuesses = reduceGuesses.map { guess in
            guard guess.automatic else {
                return guess
            }

            if
                automated ||
                    (guess.type == .Correction && !correctSpelling) ||
                    (guess.type == .Capitalization && !capitalizeSpelling)
            {
                return guess.deautomated()
            }
            
            automated = true
            return guess
        }
        
        return reduceGuesses
    }
    
}
