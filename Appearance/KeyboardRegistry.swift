//
//  KeyboardRegistry.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 6/13/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation


internal class KeyboardRegistry {
    
    internal static var sharedInstance = KeyboardRegistry()

    private var keyboardViewControllers = WeakSet<KeyboardViewController>()
    private var suggestionsViewController = WeakSet<KeyboardSuggestionsViewController>()

    // # KeyboardViewController
    internal func registerKeyboardViewController(keyboardViewController: KeyboardViewController) {
        self.keyboardViewControllers.insert(keyboardViewController)
        self.synchronize()
    }

    internal func unregisterKeyboardViewController(keyboardViewController: KeyboardViewController) {
        self.keyboardViewControllers.remove(keyboardViewController)
        self.synchronize()
    }

    // # KeyboardSuggestionsViewController
    internal func registerSuggestionsViewController(suggestionsViewController: KeyboardSuggestionsViewController) {
        self.suggestionsViewController.insert(suggestionsViewController)
        self.synchronize()
    }

    internal func unregisterSuggestionsViewController(suggestionsViewController: KeyboardSuggestionsViewController) {
        self.suggestionsViewController.remove(suggestionsViewController)
        self.synchronize()
    }

    // # Synchonization
    private func synchronize() {
        let keyboardViewController = self.keyboardViewControllers.first

        for suggestionViewController in self.suggestionsViewController {
            suggestionViewController.keyboardViewController = keyboardViewController
        }
    }
}