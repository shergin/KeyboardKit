//
//  KeyboardKeyLabel.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 3/2/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation


public struct KeyboardKeyLabel {
    public var lowercase: String
    public var uppercase: String

    public init(unified: String) {
        self.lowercase = unified
        self.uppercase = unified
    }

    public init(automated: String) {
        self.lowercase = automated.lowercaseString
        self.uppercase = automated.uppercaseString
    }

    public init(lowercase: String, uppercase: String) {
        self.lowercase = lowercase
        self.uppercase = uppercase
    }

    internal func labelWithShiftMode(shiftMode: KeyboardShiftMode) -> String {
        if shiftMode.needCapitalize() {
            return self.uppercase
        }
        else {
            return self.lowercase
        }
    }

}


// # Equatable
extension KeyboardKeyLabel: Equatable {
}

public func ==(lhs: KeyboardKeyLabel, rhs: KeyboardKeyLabel) -> Bool {
    return
        lhs.lowercase == rhs.lowercase &&
        lhs.uppercase == rhs.uppercase
}
