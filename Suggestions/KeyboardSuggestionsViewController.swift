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

    // # Public
    public weak var delegate: KeyboardSuggestionsViewControllerDelegate?
    public var suggestionModel: KeyboardSuggestionModel! = KeyboardSuggestionModel()

    public weak var keyboardViewController: KeyboardViewController? {
        didSet {
            self.suggestionModel.keyboardViewController = self.keyboardViewController
            self.updateApperanceManager()
        }
    }

    public init() {
        super.init(nibName: nil, bundle: nil)

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

//    public override func viewWillAppear(animated: Bool) {
//        super.viewWillAppear(animated)
//    }
//
//    public override func viewDidDisappear(animated: Bool) {
//        super.viewDidDisappear(animated)
//    }

//    public override func didMoveToParentViewController(parentViewController: UIViewController?) {
//        super.didMoveToParentViewController(parentViewController)
//
//        if parentViewController != nil {
//            KeyboardTextDocumentCoordinator.sharedInstance.addObserver(self)
//        }
//        else {
//            KeyboardTextDocumentCoordinator.sharedInstance.removeObserver(self)
//            self.items = []
//        }
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
        self.ignoreTextDocumentEvents = true

        defer {
            self.ignoreTextDocumentEvents = false
        }

        for _ in 0..<guess.query.placement.characters.count {
            self.textDocumentProxy.deleteBackward()
        }

        self.textDocumentProxy.insertText(guess.replacement + (addSpace ? " " : ""))

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
        let contextTail = context.substringFromIndex(context.endIndex.predecessor())
        let contextWithoutTail = context.substringToIndex(context.endIndex.predecessor())

        guard contextWithoutTail.hasSuffix(guess.replacement) else {
            return
        }

        self.lastAppliedGuess = nil

        self.ignoreTextDocumentEvents = true

        defer {
            self.ignoreTextDocumentEvents = false
        }

        // TODO: Optimize replacement!
        for _ in 0..<(guess.replacement.characters.count + contextTail.characters.count) {
            self.textDocumentProxy.deleteBackward()
        }
        self.textDocumentProxy.insertText(guess.query.placement)

        self.textDocumentProxy.insertText(contextTail)
        self.textDocumentProxy.insertText("\u{200B}") // ZERO WIDTH SPACE, fake symbol which will be removed by waiting backspace.

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
    public func keyboardTextDocumentWillInsertText(text: String) {
        guard !self.ignoreTextDocumentEvents else {
            return
        }

        guard !text.isEmpty else {
            return
        }

        if separatorChracterSet.characterIsMember(text.utf16.first!) {
            self.separatorWillBeInsertedInTextDocument()
        }
    }

    public func keyboardTextDocumentDidInsertText(text: String) {
        guard !self.ignoreTextDocumentEvents else {
            return
        }

        if !separatorChracterSet.characterIsMember(text.utf16.first!) {
            self.lastAppliedGuess = nil
        }

        self.textDidChange()
    }

    public func keyboardTextDocumentWillDeleteBackward() {
        guard !self.ignoreTextDocumentEvents else {
            return
        }

        self.revertAppliedSuggestionItemIfNeeded()
        //self.textDidChange()
    }

    public func keyboardTextDocumentDidDeleteBackward() {
        guard !self.ignoreTextDocumentEvents else {
            return
        }

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
