//
//  KeyboardSuggestionModel.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 2/17/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation


public final class KeyboardSuggestionModel {

    private var keyViewSetHashValue: Int = 0
    private var keyTable: [String: KeyboardSuggestionKey] = [:]

    internal weak var keyboardViewController: KeyboardViewController? {
        didSet {
            self.spellingSuggestionSource.keyboardViewController = self.keyboardViewController
        }
    }

    public var isSpellingSuggestionsEnabled = true
    public var isSpellingAutocorrectionEnabled = true
    public var isSpellingCapitalizationEnabled = true
    public var isEmojiSuggestionsEnabled = true
    public var isBackspaceRevertCorrection = true

    private var spellingSuggestionSource = KeyboardSpellingSuggestionSource()
    private var emojiSuggestionSource = KeyboardEmojiSuggestionSource()

    internal init() {
    }

    private var textDocumentProxy: UITextDocumentProxy {
        return UIInputViewController.rootInputViewController.textDocumentProxy
    }

    internal func shouldSuggestEmoji() -> Bool {
        return
            self.isEmojiSuggestionsEnabled
    }

    internal func shouldSuggestSpelling() -> Bool {
        return
            self.isSpellingSuggestionsEnabled &&
            self.textDocumentProxy.spellCheckingType != .No
    }

    internal func shouldСorrectSpelling() -> Bool {
        return
            self.shouldSuggestSpelling() &&
            self.isSpellingAutocorrectionEnabled &&
            self.textDocumentProxy.autocorrectionType != .No
    }

    internal func shouldCapitalizeSpelling() -> Bool {
        return
            self.shouldSuggestSpelling() &&
            self.isSpellingCapitalizationEnabled &&
            self.textDocumentProxy.autocorrectionType != .No
    }

    private func lastWordFragmentRange(context: NSString) -> NSRange {
        let lastSeparatorRange = context.rangeOfCharacterFromSet(NSCharacterSet.separatorChracterSet(), options: .BackwardsSearch)

        if lastSeparatorRange.location == NSNotFound {
            return NSMakeRange(0, context.length)
        }

        if lastSeparatorRange.location + lastSeparatorRange.length == context.length {
            return NSMakeRange(context.length, 0)
            /*
            // Old policy and approach:
            var result =
                self.lastWordFragmentRange(
                    context.substringToIndex(lastSeparatorRange.location)
                )
            result.length = context.length - result.location
            return result
            */
        }

        let lastSeparatorIndex = lastSeparatorRange.location + lastSeparatorRange.length

        return NSMakeRange(lastSeparatorIndex, context.length - lastSeparatorIndex)
    }

    public func query() -> KeyboardSuggestionQuery {
        let language = self.keyboardViewController?.keyboardLayout.language ?? "en"
        let context = self.textDocumentProxy.documentContextBeforeInput ?? ""
        let range = self.lastWordFragmentRange(context)

        var query = KeyboardSuggestionQuery()
        query.language = language
        query.context = context
        query.range = range
        return query
    }

    public func guesses(query: KeyboardSuggestionQuery, callback: ([KeyboardSuggestionGuess]) -> ()) {
        var results: (spellingGuesses: [KeyboardSuggestionGuess]?, emojiGuesses: [KeyboardSuggestionGuess]?) = (spellingGuesses: nil, emojiGuesses: nil)

        let processResults = {
            guard
                let spellingGuesses = results.spellingGuesses,
                let emojiGuesses = results.emojiGuesses
            else {
                return
            }

            var gueses: [KeyboardSuggestionGuess] = []
            gueses.appendContentsOf(spellingGuesses)
            gueses.appendContentsOf(emojiGuesses)

            callback(self.reduceGuesses(gueses))
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
        var completionsLimit = 2
        var totalSpellingLimit = 3

        var emojisLimit = 3

        var reduceGuesses = guesses.filter { (guess: KeyboardSuggestionGuess) -> Bool in
            switch guess.type {
            case .Learning, .Autoreplacement, .Capitalization, .Prediction, .Other:
                return true
            case .Correction:
                correctionsLimit -= 1
                totalSpellingLimit -= 1
                return correctionsLimit >= 0 && totalSpellingLimit >= 0
                break
            case .Completion:
                completionsLimit -= 1
                totalSpellingLimit -= 1
                return completionsLimit >= 0 && totalSpellingLimit >= 0
                break
            case .Emoji:
                emojisLimit -= 1
                return emojisLimit >= 0
                break
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

        /*
        if self.shouldСorrectSpelling() {
            var automated = false
            var hasLearningGuess = false

            reduceGuesses = reduceGuesses.map { guess in
                if guess.type == .Learning {
                    hasLearningGuess = true
                }

                if !automated && hasLearningGuess && guess.type.isKindOfCorrection {
                    var automatedGuess = guess
                    automated = true
                    automatedGuess.automatic = true
                    automatedGuess.appearance.highlighted = true
                    return automatedGuess
                }

                return guess
            }
        }
        */

        return reduceGuesses
    }

    internal func learnWord(word: String) {
        self.spellingSuggestionSource.learnWord(word)
    }

}
