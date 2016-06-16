//
//  KeyboardSuggestionModelDelegate.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 6/15/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation


public protocol KeyboardSuggestionModelDelegate: class {
    func suggestionModelDidUpdateGuesses(guesses: [KeyboardSuggestionGuess])
}


// # Optional methods
extension KeyboardSuggestionModelDelegate {
    public func suggestionModelDidUpdateGuesses(guesses: [KeyboardSuggestionGuess]) {}
}
