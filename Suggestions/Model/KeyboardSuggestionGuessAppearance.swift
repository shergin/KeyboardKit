//
//  KeyboardSuggestionGuessAppearance.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 4/11/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation


public struct KeyboardSuggestionGuessAppearance {
    var quoted: Bool = false
    var highlighted: Bool = false
    var compact: Bool = false
}


extension KeyboardSuggestionGuessAppearance {
    internal init(type: KeyboardSuggestionGuessType) {
        switch type {
        case .Emoji:
            self.compact = true
        case .Learning:
            self.quoted = true
        default:
            break
        }
    }
}


// # Equatable
extension KeyboardSuggestionGuessAppearance: Equatable {
}

public func ==(lhs: KeyboardSuggestionGuessAppearance, rhs: KeyboardSuggestionGuessAppearance) -> Bool {
    return
        lhs.quoted == rhs.quoted &&
        lhs.highlighted == rhs.highlighted &&
        lhs.compact == rhs.compact
}
