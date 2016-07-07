//
//  suitableKeyboardLayouts.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 5/16/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation


private let keyboardNamePattern = try! NSRegularExpression(pattern: "^([a-z]+)(_([a-z]+))?(-([a-z]))?(@(.+))?$", options: [.CaseInsensitive])

private func keyboardLayoutByBundleId(keyboard: String) -> KeyboardLayout? {

    guard let match = keyboardNamePattern.firstMatchInString(
            keyboard,
            options: [],
            range: NSRange(location: 0, length: keyboard.characters.count)
        ) else
    {
        return nil
    }

    let fragmentAtIndex = { (index: Int) -> String? in
        let range = match.rangeAtIndex(index)
        guard range.location != NSNotFound else {
            return nil
        }

        return NSString(string: keyboard).substringWithRange(range)
    }

    let language = fragmentAtIndex(1)
    let country = fragmentAtIndex(3)
    let region = fragmentAtIndex(5)
    let parameters = fragmentAtIndex(7)

    for keyboardLayout in allKeyboardLayouts {
        if keyboardLayout.language == language {
            return keyboardLayout
        }
    }

    return nil
}


public func suitableKeyboardLayouts() -> [KeyboardLayout] {
    guard let keyboards = NSUserDefaults.standardUserDefaults().dictionaryRepresentation()["AppleKeyboards"] as? [String] else {
        return [englishKeyboardLayout]
    }

    var layouts: [KeyboardLayout] = []

    for keyboard in keyboards {
        guard let layout = keyboardLayoutByBundleId(keyboard) else {
            continue
        }

        layouts.append(layout)
    }

    guard layouts.count > 0 else {
        return [englishKeyboardLayout]
    }

    return layouts
}
