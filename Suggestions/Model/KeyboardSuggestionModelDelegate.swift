//
//  KeyboardSuggestionModelDelegate.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 6/15/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation


public protocol KeyboardSuggestionModelDelegate: class {
    func suggestionModelWillUpdateGuesses(query query: KeyboardSuggestionQuery)
    func suggestionModelDidUpdateGuesses(query query: KeyboardSuggestionQuery, guesses: [KeyboardSuggestionGuess])
}

/*
// # Optional methods
extension KeyboardSuggestionModelDelegate {
    public func suggestionModelWillUpdateGuesses(query query: KeyboardSuggestionQuery) {}
    public func suggestionModelDidUpdateGuesses(query query: KeyboardSuggestionQuery, guesses: [KeyboardSuggestionGuess]) {}
}
*/