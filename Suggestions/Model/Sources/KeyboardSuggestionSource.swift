//
//  KeyboardSuggestionSource.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 4/8/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation


typealias KeyboardSuggestionSourceCallback = ([KeyboardSuggestionGuess]) -> ()

protocol KeyboardSuggestionSource {
    func suggest(query: KeyboardSuggestionQuery, callback: KeyboardSuggestionSourceCallback)
}
