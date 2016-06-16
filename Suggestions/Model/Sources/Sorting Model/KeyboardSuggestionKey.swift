//
//  KeyboardSuggestionKey.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 2/17/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation


internal struct KeyboardSuggestionKey {
    let output: String
    let frame: CGRect
}


extension KeyboardSuggestionKey {
    var center: CGPoint {
        return CGPoint(x: self.frame.midX, y: self.frame.midY)
    }
}


internal struct KeyboardSuggestionKeyStream {
    var source: String
    var keys: [KeyboardSuggestionKey?]
    var score: Double
}
