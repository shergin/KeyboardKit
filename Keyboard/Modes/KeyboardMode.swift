//
//  KeyboardMode.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 1/14/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation


public struct KeyboardMode {
    public var pageNumber: Int = 0
    public var colorMode: KeyboardColorMode = .Light
    public var vibrancyMode: KeyboardVibrancyMode = .Transparent
    public var shiftMode: KeyboardShiftMode = .Disabled
    public var sizeMode: KeyboardSizeMode = .Small
}


extension KeyboardMode {
    public var keyboardAppearanceVariant: KeyboardAppearanceVariant {
        return KeyboardAppearanceVariant(
            colorMode: self.colorMode,
            vibrancyMode: self.vibrancyMode,
            sizeMode: self.sizeMode
        )
    }
}

extension KeyboardMode {
    public init(inputViewController: UIInputViewController) {
        self.colorMode = KeyboardColorMode(keyboardAppearance: inputViewController.textDocumentProxy.keyboardAppearance!)
        self.sizeMode = KeyboardSizeMode.suitable()
    }

    public init(textInputTraits: UITextInputTraits) {
        self.colorMode = KeyboardColorMode(keyboardAppearance: textInputTraits.keyboardAppearance!)
        self.sizeMode = KeyboardSizeMode.suitable()
    }

    public mutating func toggleShiftState() {
        self.shiftMode = (self.shiftMode == .Disabled) ? .Enabled : .Disabled
    }
}



// # Equitable
extension KeyboardMode: Equatable {
}

public func ==(lhs: KeyboardMode, rhs: KeyboardMode) -> Bool {
    return
        lhs.pageNumber == rhs.pageNumber &&
        lhs.colorMode == rhs.colorMode &&
        lhs.vibrancyMode == rhs.vibrancyMode &&
        lhs.shiftMode == rhs.shiftMode &&
        lhs.sizeMode == rhs.sizeMode
}


// # Hashable
extension KeyboardMode: Hashable {
    public var hashValue: Int {
        return
            self.pageNumber +
            self.colorMode.rawValue << 2 +
            self.vibrancyMode.rawValue << 3 +
            self.shiftMode.rawValue << 4 +
            self.sizeMode.rawValue << 5
    }
}
