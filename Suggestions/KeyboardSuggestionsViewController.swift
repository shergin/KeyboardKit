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
            self.itemsView.items = guesses
            self.delegate?.suggestionsViewControllerDidUpdateSuggestionItems()
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
    public func suggestionModelDidUpdateGuesses(guesses: [KeyboardSuggestionGuess]) {

        if #available(iOS 9.0, *) {
            self.loadViewIfNeeded()
        }
        else {
            let _ = self.view
        }

        // FIXME:
        self.updateApperanceManager()

        self.guesses = guesses
    }
}
