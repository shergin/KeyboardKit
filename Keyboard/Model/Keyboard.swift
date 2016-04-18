//
//  KeyboardLayout.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 1/12/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation


public struct KeyboardLayout {
    public var pages: [KeyboardPage]
    public var language: String = "ml"
    public var type: KeyboardLayoutType = .Other

    public init() {
        self.pages = []
    }

    public var id: String {
        return "\(self.type)-\(self.language)"
    }
}


extension KeyboardLayout {
    public func localizedTitle(prefix prefix: String = "keyboard-layout.") -> String {
        var string = NSLocalizedString("\(prefix)\(self.language)", value: "", comment: "")
        if !string.isEmpty {
            return string
        }

        string = NSLocalizedString("\(prefix)\(self.id)", value: "", comment: "")

        if !string.isEmpty {
            return string
        }

        return self.id
    }
}

extension KeyboardLayout {
    public var spaceKey: KeyboardKey? {
        get {
            return self.pages[0].rows[3][2]
        }

        set {
            self.pages[0].rows[3][2] = newValue!
        }
    }
}