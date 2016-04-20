//
//  KeyboardSuggestionGuess.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 4/8/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation


public struct KeyboardSuggestionGuess {
    var query: KeyboardSuggestionQuery = KeyboardSuggestionQuery()
    var replacement: String = ""
    var type: KeyboardSuggestionGuessType = .Other
    var automatic: Bool = false
    var appearance: KeyboardSuggestionGuessAppearance = KeyboardSuggestionGuessAppearance()
}


extension KeyboardSuggestionGuess {
    public init(query: KeyboardSuggestionQuery, type: KeyboardSuggestionGuessType, replacement: String, automatic: Bool = false) {
        self.query = query
        self.type = type
        self.replacement = replacement
        self.automatic = automatic

        self.adjustAppearance()
    }

    public func deautomated() -> KeyboardSuggestionGuess {
        var guess = self
        guess.automatic = false
        guess.adjustAppearance()
        return guess
    }

    public mutating func adjustAppearance() {
        self.appearance.compact = self.type == .Emoji
        self.appearance.quoted = self.type == .Learning
        self.appearance.highlighted = self.automatic
    }
}


// # Equatable
extension KeyboardSuggestionGuess: Equatable {
}

public func ==(lhs: KeyboardSuggestionGuess, rhs: KeyboardSuggestionGuess) -> Bool {
    return
        lhs.query == rhs.query &&
        lhs.replacement == rhs.replacement &&
        lhs.type == rhs.type &&
        lhs.automatic == rhs.automatic &&
        lhs.appearance == rhs.appearance
}
