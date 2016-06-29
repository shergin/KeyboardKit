//
//  KeyboardSuggestionQuery.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 4/8/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation


public struct KeyboardSuggestionQuery {
    public var language: String = "en"
    public var context: String = ""
    public var range: NSRange = NSRange(location: 0, length: 0)
}


extension KeyboardSuggestionQuery {
    public var placement: String {
        return (context as NSString).substringWithRange(range) as String
    }
}


// # Equatable
extension KeyboardSuggestionQuery: Equatable {}

public func ==(lhs: KeyboardSuggestionQuery, rhs: KeyboardSuggestionQuery) -> Bool {
    return
        lhs.context == rhs.context &&
        lhs.range == rhs.range
}


// # NSRange Equatable
extension NSRange: Equatable {}

public func ==(lhs: NSRange, rhs: NSRange) -> Bool {
    return
        lhs.location == rhs.location &&
        lhs.length == rhs.length
}
