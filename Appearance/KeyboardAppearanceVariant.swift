//
//  KeyboardAppearanceVariant.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 2/26/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation


public struct KeyboardAppearanceVariant {
    public var colorMode: KeyboardColorMode = .Light
    public var vibrancyMode: KeyboardVibrancyMode = .Transparent
    public var sizeMode: KeyboardSizeMode = .Small
}


extension KeyboardAppearanceVariant {
    static func suitable() -> KeyboardAppearanceVariant {
        var appearanceVariant = KeyboardAppearanceVariant()
        appearanceVariant.colorMode = KeyboardColorMode.suitable()
        appearanceVariant.sizeMode = KeyboardSizeMode.suitable()
        return appearanceVariant
    }
}


// # Equatable
extension KeyboardAppearanceVariant: Equatable {
}

public func ==(lhs: KeyboardAppearanceVariant, rhs: KeyboardAppearanceVariant) -> Bool {
    return
        lhs.colorMode == rhs.colorMode &&
        lhs.vibrancyMode == rhs.vibrancyMode &&
        lhs.sizeMode == rhs.sizeMode
}


// # Hashable
extension KeyboardAppearanceVariant: Hashable {
    public var hashValue: Int {
        return
            self.colorMode.hashValue +
            self.vibrancyMode.hashValue << 4 +
            self.sizeMode.hashValue << 8
    }
}
