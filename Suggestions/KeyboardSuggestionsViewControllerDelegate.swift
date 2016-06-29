//
//  KeyboardSuggestionsViewControllerDelegate.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 3/24/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation


public protocol KeyboardSuggestionsViewControllerDelegate: class {
    func suggestionsViewControllerWillUpdateSuggestionItems(query query: KeyboardSuggestionQuery)
    func suggestionsViewControllerDidUpdateSuggestionItems(query query: KeyboardSuggestionQuery)
}


/*
Looks like it is bad idea.

// # Optional methods
extension KeyboardSuggestionsViewControllerDelegate {
    public func suggestionsViewControllerDidUpdateSuggestionItems(query query: KeyboardSuggestionQuery) {}
    public func suggestionsViewControllerWillUpdateSuggestionItems(query query: KeyboardSuggestionQuery) {}
}
*/