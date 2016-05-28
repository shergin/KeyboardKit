//
//  KeyboardSuggestionGuessType.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 4/11/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation


public enum KeyboardSuggestionGuessType: Int {
    case Correction
    case Completion
    case Capitalization
    case Autoreplacement
    case Prediction
    case Emoji
    case Learning
    case Other
}


extension KeyboardSuggestionGuessType {
    var isKindOfCorrection: Bool {
        return
            self == .Correction ||
            self == .Completion ||
            self == .Capitalization ||
            self == .Autoreplacement
    }
}
