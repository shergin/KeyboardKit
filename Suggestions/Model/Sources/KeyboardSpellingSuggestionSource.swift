//
//  KeyboardSpellingSuggestionSource.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 4/8/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation


internal final class KeyboardSpellingSuggestionSource: KeyboardSuggestionSource {

    private let queue: dispatch_queue_t = {
        if rand() % 10 == 0 {
            return dispatch_get_main_queue()
        }

        return dispatch_queue_create("com.keyboard-kit.spelling-suggestion-source", DISPATCH_QUEUE_SERIAL)
    } ()

    private let sortingModel = KeyboardSuggestionGuessesSortingModel()
    private var lastQuery: KeyboardSuggestionQuery?
    private let checker = UITextChecker()

    private var replacementPhrases: [String: String] = [:]
    private var replacementNames: [String: String] = [:]

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

            let inputViewController = UIInputViewController.rootInputViewController

            let semaphore = dispatch_semaphore_create(0)
            var lexicon: UILexicon!
            inputViewController.requestSupplementaryLexiconWithCompletion() { supplementaryLexicon in
                lexicon = supplementaryLexicon
                dispatch_semaphore_signal(semaphore)
            }
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)

            var replacementPhrases: [String: String] = [:]
            var replacementNames: [String: String] = [:]

            for entry in lexicon.entries {
                if entry.documentText == entry.userInput {
                    if entry.documentText.isCamelcase() {
                        replacementNames[entry.userInput.lowercaseString] = entry.documentText
                    }
                }
                else {
                    replacementPhrases[entry.userInput.lowercaseString] = entry.documentText
                }
            }

            // TODO: Move outside.
            replacementPhrases["i"] = "I"

            self?.replacementPhrases = replacementPhrases
            self?.replacementNames = replacementNames
        }
    }

    internal func suggest(query: KeyboardSuggestionQuery, callback: KeyboardSuggestionSourceCallback) {
        self.lastQuery = query

        let sortingModel = self.sortingModel

        dispatch_async(self.queue) { [weak self] in
            var guesses: [KeyboardSuggestionGuess] = []

            defer {
                dispatch_async(dispatch_get_main_queue()) {
                    callback(guesses)
                }
            }

            guard let strongSelf = self else {
                return
            }

            guard self?.lastQuery == query else {
                return
            }

            guard let vocabulary = KeyboardVocabulary.vocabulary(language: query.language) else {
                return
            }

            let isSpellProperly = vocabulary.isSpellProperly(query)
            let completions = vocabulary.completions(query)
            let unsortedCorrections = vocabulary.corrections(query)
            let corrections = sortingModel.sortReplacements(unsortedCorrections, placement: query.placement)

            var automatic = false
            var hasAutoreplacement = false

            log("placement: \(query.placement), isSpellProperly: \(isSpellProperly), corrections: \(corrections), completions: \(completions)")

            var replacements = Set<String>()

            // Autoreplacement
            if let replacement = strongSelf.replacementPhrases[query.placement.lowercaseString]
                where !replacements.contains(replacement) && query.placement != replacement {

                replacements.insert(replacement)

                automatic = true

                guesses.append(
                    KeyboardSuggestionGuess(
                        query: query,
                        type: .Autoreplacement,
                        replacement: replacement,
                        automatic: automatic
                    )
                )

                hasAutoreplacement = hasAutoreplacement || automatic
            }

            // Name Capitalization
            if let replacement = strongSelf.replacementNames[query.placement.lowercaseString]
                where !replacements.contains(replacement) && query.placement != replacement {

                replacements.insert(replacement)

                automatic = vocabulary.score(replacement.lowercaseString) == nil

                guesses.append(
                    KeyboardSuggestionGuess(
                        query: query,
                        type: .Capitalization,
                        replacement: replacement,
                        automatic: automatic
                    )
                )

                hasAutoreplacement = hasAutoreplacement || automatic
            }

            // Corrections
            for correction in corrections {
                let replacement = correction
                guard !replacements.contains(replacement) else {
                    continue
                }

                replacements.insert(replacement)

                automatic = !isSpellProperly

                guesses.append(
                    KeyboardSuggestionGuess(
                        query: query,
                        type: .Correction,
                        replacement: replacement,
                        automatic: automatic
                    )
                )

                hasAutoreplacement = hasAutoreplacement || automatic
            }

            // Completions
            for completion in completions {
                let replacement = completion
                guard !replacements.contains(replacement) else {
                    continue
                }

                replacements.insert(replacement)

                automatic = !isSpellProperly
                guesses.append(
                    KeyboardSuggestionGuess(
                        query: query,
                        type: .Completion,
                        replacement: replacement,
                        automatic: automatic
                    )
                )

                hasAutoreplacement = hasAutoreplacement || automatic
            }

            // Learning
            if hasAutoreplacement {
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
