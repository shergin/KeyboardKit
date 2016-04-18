//
//  KeyboardWordSuggestionSource.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 4/8/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation


internal final class KeyboardWordSuggestionSource: KeyboardSuggestionSource {

    private let queue = dispatch_queue_create("com.keyboard-kit.word-suggestion-source", DISPATCH_QUEUE_SERIAL)

    private let sortingModel = KeyboardSuggestionGuessesSortingModel()
    private var lastQuery: KeyboardSuggestionQuery?
    private let checker = UITextChecker()

    internal weak var keyboardViewController: KeyboardViewController? {
        didSet {
            self.sortingModel.keyboardViewController = self.keyboardViewController
        }
    }

    internal init() {
        self.sortingModel.keyboardViewController = nil
    }

    internal func learnWord(word: String) {
        self.checker.dynamicType.learnWord(word)
    }

    internal func suggest(query: KeyboardSuggestionQuery, callback: KeyboardSuggestionSourceCallback) {

        self.lastQuery = query

        let checker = self.checker
        let sortingModel = self.sortingModel

        dispatch_async(self.queue) { [weak self] in
            var guesses: [KeyboardSuggestionGuess] = []

            defer {
                dispatch_async(dispatch_get_main_queue()) {
                    callback(guesses)
                }
            }

            guard self?.lastQuery == query else {
                return
            }

            let isMisspelled =
                checker.rangeOfMisspelledWordInString(
                    query.context,
                    range: query.range,
                    startingAt: query.range.location,
                    wrap: false,
                    language: query.language
                ).location != NSNotFound

            let completions =
                checker.completionsForPartialWordRange(
                    query.range,
                    inString: query.context,
                    language: query.language
                ) as? [String] ?? []

            let unsortedCorrections =
                checker.guessesForWordRange(
                    query.range,
                    inString: query.context,
                    language: query.language
                ) as? [String] ?? []


            let corrections =
                sortingModel.sortReplacements(unsortedCorrections, placement: query.placement)

            print("unsortedCorrections: \(unsortedCorrections)")
            print("query.placement: \(query.placement)")
            print("corrections: \(corrections)")

            // Learning
            if isMisspelled {
                guesses.append(
                    KeyboardSuggestionGuess(query: query, type: .Learning, replacement: query.placement)
                )
            }

            // Corrections
            for correction in corrections {
                guesses.append(
                    KeyboardSuggestionGuess(query: query, type: .Correction, replacement: correction)
                )
            }

            // Completions
            for completion in completions {
                guesses.append(
                    KeyboardSuggestionGuess(query: query, type: .Completion, replacement: completion)
                )
            }

            // `defer {}` will call `callback`.
        }
    }
    
}
