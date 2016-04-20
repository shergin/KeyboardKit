//
//  KeyboardSpellingSuggestionSource.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 4/8/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation


internal final class KeyboardSpellingSuggestionSource: KeyboardSuggestionSource {

    private let queue = dispatch_queue_create("com.keyboard-kit.word-suggestion-source", DISPATCH_QUEUE_SERIAL)

    private let sortingModel = KeyboardSuggestionGuessesSortingModel()
    private var lastQuery: KeyboardSuggestionQuery?
    private let checker = UITextChecker()
    private var autoreplacements: [String: String] = [:]

    internal weak var keyboardViewController: KeyboardViewController? {
        didSet {
            self.sortingModel.keyboardViewController = self.keyboardViewController
        }
    }

    internal init() {
        self.sortingModel.keyboardViewController = nil
        self.learnAllWordsFromLexicon()
    }

    internal func learnWord(word: String) {
        dispatch_async(self.queue) { [weak self] in
            guard let checker = self?.checker else {
                return
            }

            // Learn this word _globally_.
            checker.dynamicType.learnWord(word)
        }
    }

    private func learnAllWordsFromLexicon() {
        dispatch_async(self.queue) { [weak self] in
            guard let checker = self?.checker else {
                return
            }

            guard let inputViewController = UIInputViewController.rootInputViewController else {
                return
            }

            let semaphore = dispatch_semaphore_create(0)
            var lexicon: UILexicon!
            inputViewController.requestSupplementaryLexiconWithCompletion() { supplementaryLexicon in
                lexicon = supplementaryLexicon
                dispatch_semaphore_signal(semaphore)
            }
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)

            var autoreplacements: [String: String] = [:]

            for entry in lexicon.entries {
                if entry.documentText == entry.userInput && entry.documentText == entry.documentText.lowercaseString {
                    continue
                }

                autoreplacements[entry.userInput.lowercaseString] = entry.documentText
            }

            self?.autoreplacements = autoreplacements
        }
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

            var hasAutoreplacement = false

//            print("unsortedCorrections: \(unsortedCorrections)")
//            print("query.placement: \(query.placement)")
//            print("corrections: \(corrections)")

            var replacements = Set<String>()

            // Autoreplacement
            if let autoreplacement = self!.autoreplacements[query.placement.lowercaseString] {
                let replacement = autoreplacement
                replacements.insert(replacement)

                guesses.append(
                    KeyboardSuggestionGuess(
                        query: query,
                        type: .Autoreplacement,
                        replacement: replacement,
                        automatic: query.placement.characters.count > 2
                    )
                )

                hasAutoreplacement = true
            }

            // Corrections
            for correction in corrections {
                let replacement = correction
                guard !replacements.contains(replacement) else {
                    continue
                }

                replacements.insert(replacement)

                guesses.append(
                    KeyboardSuggestionGuess(
                        query: query,
                        type: .Correction,
                        replacement: replacement,
                        automatic: isMisspelled
                    )
                )
            }

            // Completions
            for completion in completions {
                let replacement = completion
                guard !replacements.contains(replacement) else {
                    continue
                }

                replacements.insert(replacement)

                guesses.append(
                    KeyboardSuggestionGuess(
                        query: query,
                        type: .Completion,
                        replacement: replacement,
                        automatic: isMisspelled
                    )
                )
            }

            // Learning
            if isMisspelled || hasAutoreplacement {
                guesses.insert(
                    KeyboardSuggestionGuess(
                        query: query,
                        type: .Learning,
                        replacement: query.placement
                    ),
                    atIndex: 0
                )
            }

            // `defer {}` will call `callback`.
        }
    }
    
}
