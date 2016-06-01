//
//  KeyboardEmojiViewControllerDelegate.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 6/1/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import UIKit


public protocol KeyboardEmojiViewControllerDelegate: class {
    func emojiViewController(keyboardEmojiViewController: KeyboardEmojiViewController, emojiCategoryWasChanged emojiCategory: KeyboardEmojiCategory)
}


// # Optionality
extension KeyboardEmojiViewControllerDelegate {
    public func emojiViewController(keyboardEmojiViewController: KeyboardEmojiViewController, emojiCategoryWasChanged emojiCategory: KeyboardEmojiCategory) {}
}
