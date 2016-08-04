//
//  KeyboardNumericKeyType.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 8/3/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation


internal enum KeyboardNumericKeyType {
    case Nothing
    case Number(number: Int, letters: String)
    case Backspace
}


extension KeyboardNumericKeyType {
    internal var isSpecial: Bool {
        if case Number(let number, let letters) = self {
            return false
        }

        return true
    }
}
