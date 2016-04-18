//
//  KeyboardKeyMode.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 1/15/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation

public struct KeyboardKeyMode {
    public var popupMode: KeyboardKeyPopupTypeMode = .None

    public var activityMode: KeyboardKeyActivityMode = .Enabled
    public var highlightMode: KeyboardKeyHighlightMode = .None
    public var selectionMode: KeyboardKeySelectionMode = .None

    public var compoundModificationMode: KeyboardKeyCompoundModificationMode {
        if self.activityMode == .Disabled {
            return .Disabled
        }

        if self.highlightMode == .Highlighted {
            return .Highlighted
        }

        if self.selectionMode == .Selected {
            return .Selected
        }

        return .Normal
    }
}


extension KeyboardKeyMode: Equatable {
}

public func ==(lhs: KeyboardKeyMode, rhs: KeyboardKeyMode) -> Bool {
    return
        lhs.activityMode == rhs.activityMode &&
        lhs.highlightMode == rhs.highlightMode &&
        lhs.selectionMode == rhs.selectionMode &&
        lhs.popupMode == rhs.popupMode
}


extension KeyboardKeyMode: Hashable {
    public var hashValue: Int {
        return
            self.activityMode.rawValue * 10^0 +
            self.highlightMode.rawValue * 10^1 +
            self.selectionMode.rawValue * 10^2 +
            self.popupMode.rawValue * 10^3
    }
}
