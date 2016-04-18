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
    public init(query: KeyboardSuggestionQuery, type: KeyboardSuggestionGuessType, replacement: String) {
        self.query = query
        self.type = type
        self.replacement = replacement

        self.appearance = KeyboardSuggestionGuessAppearance(type: self.type)
    }
}


// # Equatable
extension KeyboardSuggestionGuess: Equatable {
}

public func ==(lhs: KeyboardSuggestionGuess, rhs: KeyboardSuggestionGuess) -> Bool {
    return
        lhs.query == rhs.query &&
        lhs.replacement == rhs.replacement &&
        lhs.automatic == rhs.automatic
}
