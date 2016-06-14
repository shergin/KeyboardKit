//
//  KeyboardSuggestionsViewController.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 1/20/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import UIKit


public class KeyboardSuggestionsViewController: UIViewController {

    private var textDocumentProxy: UITextDocumentProxy {
        return UIInputViewController.rootInputViewController.textDocumentProxy
    }

    private var itemsView: KeyboardSuggestionItemsView!

    private var ignoreTextDocumentEvents = false
    private var guessesIsObsolete = false

    public private(set) var items: [KeyboardSuggestionGuess] = [] {
        didSet {
            self.itemsView.items = items
        }
    }

    private var lastAppliedGuess: KeyboardSuggestionGuess?
    private var lastQuery: KeyboardSuggestionQuery?
    private var characterBeforeDeleteBackward: String?

    internal weak var keyboardViewController: KeyboardViewController? {
        didSet {
            guard self.suggestionModel.keyboardViewController != self.keyboardViewController else {
                return
            }

            self.suggestionModel.keyboardViewController = self.keyboardViewController
            self.updateApperanceManager()
        }
    }

    // # Public
    public weak var delegate: KeyboardSuggestionsViewControllerDelegate?
    public var suggestionModel: KeyboardSuggestionModel! = KeyboardSuggestionModel()

    public init() {
        super.init(nibName: nil, bundle: nil)
        KeyboardRegistry.sharedInstance.registerSuggestionsViewController(self)

        KeyboardTextDocumentCoordinator.sharedInstance.addObserver(self)
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func loadView() {
        super.loadView()

        self.itemsView = KeyboardSuggestionItemsView(frame: self.view.bounds)
        self.itemsView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        self.itemsView.delegate = self

        self.updateApperanceManager()

        self.view.addSubview(self.itemsView)
    }

    func updateApperanceManager() {
        guard let itemsView = self.itemsView else {
            return
        }

        itemsView.appearanceManager = self.keyboardViewController?.appearanceManager
    }

//    public override func viewDidAppear(animated: Bool) {
//        super.viewDidAppear(animated)
//        KeyboardRegistry.sharedInstance.registerSuggestionsViewController(self)
//    }
//
//    public override func viewWillDisappear(animated: Bool) {
//        KeyboardRegistry.sharedInstance.unregisterSuggestionsViewController(self)
//        super.viewWillDisappear(animated)
//    }

    private func updateGuesses() {

        if #available(iOS 9.0, *) {
            self.loadViewIfNeeded()
        }
        else {
            let _ = self.view
        }

        self.guessesIsObsolete = true

        let query = self.suggestionModel.query()

        self.lastQuery = query

        self.suggestionModel.guesses(query) { items in
            guard self.lastQuery == query else {
                return
            }

            // FIXME:
            self.itemsView.appearanceManager = self.keyboardViewController?.appearanceManager


            self.lastQuery = nil
            self.items = items
            self.guessesIsObsolete = false

            self.delegate?.suggestionsViewControllerDidUpdateSuggestionItems()
        }
    }

    private func textDidChange() {
        self.updateGuesses()
    }

    private func applyGuest(guess: KeyboardSuggestionGuess, addSpace: Bool = false) {
        let textDocumentProxy = self.textDocumentProxy

        textDocumentProxy.performWithoutNotifications { 
            for _ in 0..<guess.query.placement.characters.count {
                textDocumentProxy.deleteBackward()
            }

            textDocumentProxy.insertText(guess.replacement + (addSpace ? " " : ""))
        }

        self.lastAppliedGuess = guess
    }

    private func revertAppliedSuggestionItemIfNeeded() {
        guard let guess = self.lastAppliedGuess else {
            return
        }

        guard self.suggestionModel.isBackspaceRevertCorrection else {
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

        self.suggestionModel.learnWord(guess.replacement.trim())
    }

    private func separatorWillBeInsertedInTextDocument() {
        guard !self.guessesIsObsolete else {
            return
        }

        guard let item = (self.items.filter { $0.automatic }.first) else {
            return
        }

        self.applyGuest(item)
    }
}

extension KeyboardSuggestionsViewController: KeyboardTextDocumentObserver {

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
}

extension KeyboardSuggestionsViewController: KeyboardSuggestionItemsViewDelegate {
    func itemWasActivated(guess: KeyboardSuggestionGuess) {
        guard !self.guessesIsObsolete else {
            return
        }

        self.applyGuest(guess, addSpace: true)

        self.textDidChange()
    }
}
