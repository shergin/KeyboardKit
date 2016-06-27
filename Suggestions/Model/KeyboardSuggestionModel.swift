//
//  KeyboardSuggestionModel.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 2/17/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation


public final class KeyboardSuggestionModel {

    private var ignoreTextDocumentEvents = false
    private var lastAppliedGuess: KeyboardSuggestionGuess?
    private var lastQuery: KeyboardSuggestionQuery?
    private var characterBeforeDeleteBackward: String?

    internal var spellingSuggestionSource = KeyboardSpellingSuggestionSource()
    internal var emojiSuggestionSource = KeyboardEmojiSuggestionSource()

    public var isSpellingSuggestionsEnabled = true
    public var isSpellingAutocorrectionEnabled = true
    public var isSpellingCapitalizationEnabled = true
    public var isEmojiSuggestionsEnabled = true
    public var isBackspaceRevertCorrection = true

    public private(set) var guesses: [KeyboardSuggestionGuess] = []
    public weak var delegate: KeyboardSuggestionModelDelegate?

    internal weak var keyboardViewController: KeyboardViewController? {
        didSet {
            self.spellingSuggestionSource.keyboardViewController = self.keyboardViewController
        }
    }

    internal init() {
        KeyboardRegistry.sharedInstance.registerSuggestionModel(self)
        KeyboardTextDocumentCoordinator.sharedInstance.addObserver(self)
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
            return NSRange(location: 0, length: context.length)
        }

        if lastSeparatorRange.location + lastSeparatorRange.length == context.length {
            return NSRange(location: context.length, length: 0)
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

        return NSRange(location: lastSeparatorIndex, length: context.length - lastSeparatorIndex)
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

    internal func learnWord(word: String) {
        self.spellingSuggestionSource.learnWord(word.trim())
    }

    private func updateGuesses() {
        self.guesses = []
        let query = self.query()
        self.lastQuery = query

        self.generateGuesses(query) { guesses in
            guard self.lastQuery == query else {
                return
            }

            self.lastQuery = nil
            self.guesses = guesses
            self.delegate?.suggestionModelDidUpdateGuesses(guesses)
        }
    }

    private func textDidChange() {
        self.updateGuesses()
    }

    internal func applyGuest(guess: KeyboardSuggestionGuess, addSpace: Bool = false) {
        guard self.guesses.contains(guess) else {
            return
        }

        KeyboardTextDocumentCoordinator.sharedInstance.dispatchTextWillChange()
        defer {
            KeyboardTextDocumentCoordinator.sharedInstance.dispatchTextDidChange()
        }

        let textDocumentProxy = self.textDocumentProxy

        textDocumentProxy.performWithoutNotifications {
            for _ in 0..<guess.query.placement.characters.count {
                textDocumentProxy.deleteBackward()
            }

            textDocumentProxy.insertText(guess.replacement + (addSpace ? " " : ""))
        }

        if guess.type == .Learning {
            self.learnWord(guess.replacement)
        }

        self.lastAppliedGuess = guess
    }

    private func revertAppliedSuggestionItemIfNeeded() {
        guard let guess = self.lastAppliedGuess else {
            return
        }

        guard self.isBackspaceRevertCorrection else {
            return
        }

        let context = self.textDocumentProxy.documentContextBeforeInput ?? ""

        var contextTailLength: Int = 0

        // And now two cases for tailes:
        if context.hasSuffix(". ") {
            contextTailLength = 2
        }
        else if context.hasSuffix(" ") {
            contextTailLength = 1
        }

        let contextTailIndex = context.endIndex.advancedBy(-contextTailLength)
        let contextTail = context.substringFromIndex(contextTailIndex)
        let contextHead = context.substringToIndex(contextTailIndex)

        guard contextHead.hasSuffix(guess.replacement) else {
            return
        }

        self.lastAppliedGuess = nil

        let textDocumentProxy = self.textDocumentProxy

        textDocumentProxy.performWithoutNotifications {
            // TODO: Optimize replacement!
            for _ in 0..<(guess.replacement.characters.count + contextTailLength) {
                textDocumentProxy.deleteBackward()
            }
            textDocumentProxy.insertText(guess.query.placement)

            textDocumentProxy.insertText(contextTail)
            textDocumentProxy.insertText("\u{200B}") // ZERO WIDTH SPACE, fake symbol which will be removed by waiting backspace.
        }

        self.learnWord(guess.query.placement)
    }

    private func separatorWillBeInsertedInTextDocument() {
        guard let item = (self.guesses.filter { $0.automatic }.first) else {
            return
        }

        self.applyGuest(item)
    }
}


extension KeyboardSuggestionModel: KeyboardTextDocumentObserver {

    public var observesTextDocumentEvents: Bool {
        return !self.ignoreTextDocumentEvents
    }

    public func keyboardTextDocumentWillInsertText(text: String) {
        guard !text.isEmpty else {
            return
        }

        if NSCharacterSet.separatorChracterSet().characterIsMember(text.utf16.first!) {
            self.separatorWillBeInsertedInTextDocument()
        }
    }

    public func keyboardTextDocumentDidInsertText(text: String) {
        guard !text.isEmpty else {
            return
        }

        if !NSCharacterSet.separatorChracterSet().characterIsMember(text.utf16.first!) {
            self.lastAppliedGuess = nil
        }

        self.textDidChange()
    }

    public func keyboardTextDocumentWillDeleteBackward() {
        self.revertAppliedSuggestionItemIfNeeded()
    }

    public func keyboardTextDocumentDidDeleteBackward() {
        self.textDidChange()
    }

    public func keyboardTextDocumentDidChange() {
        self.textDidChange()
    }
}
