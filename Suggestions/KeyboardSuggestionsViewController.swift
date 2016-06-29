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

    public internal(set) var guesses: [KeyboardSuggestionGuess] = [] {
        didSet {
            self.updateApperanceManager()
            self.itemsView.items = guesses
        }
    }

    // # Public
    public weak var delegate: KeyboardSuggestionsViewControllerDelegate?
    public var suggestionModel = KeyboardSuggestionModel()

    public init() {
        super.init(nibName: nil, bundle: nil)
        self.suggestionModel.delegate = self
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

        itemsView.appearanceManager = self.suggestionModel.keyboardViewController?.appearanceManager
    }
}


extension KeyboardSuggestionsViewController: KeyboardSuggestionItemsViewDelegate {

    func itemWasActivated(guess: KeyboardSuggestionGuess) {
        self.suggestionModel.applyGuest(guess, addSpace: true)
    }
}


extension KeyboardSuggestionsViewController: KeyboardSuggestionModelDelegate {

    public func suggestionModelWillUpdateGuesses(query query: KeyboardSuggestionQuery) {
        self.delegate?.suggestionsViewControllerWillUpdateSuggestionItems(query: query)
    }

    public func suggestionModelDidUpdateGuesses(query query: KeyboardSuggestionQuery, guesses: [KeyboardSuggestionGuess]) {
        if #available(iOS 9.0, *) {
            self.loadViewIfNeeded()
        } else {
            let _ = self.view
        }

        self.guesses = guesses

        self.delegate?.suggestionsViewControllerDidUpdateSuggestionItems(query: query)
    }
}
