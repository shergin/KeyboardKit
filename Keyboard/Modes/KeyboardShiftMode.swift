//
//  KeyboardShiftMode.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 1/12/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation

public enum KeyboardShiftMode: Int {
    case Disabled
    case Enabled
    case Locked
}

extension KeyboardShiftMode {

    func needCapitalize() -> Bool {
        return self != .Disabled
    }

    mutating func toggle() {
        self = (self == .Disabled) ? .Enabled : .Disabled
    }

    mutating func toggleLock() {
        self = (self == .Disabled) ? .Locked : .Disabled
    }

}

