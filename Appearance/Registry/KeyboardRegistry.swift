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
    private var suggestionModels = WeakSet<KeyboardSuggestionModel>()

    // # KeyboardViewController
    internal func registerKeyboardViewController(keyboardViewController: KeyboardViewController) {
        self.keyboardViewControllers.insert(keyboardViewController)
        self.synchronize()
    }

    internal func unregisterKeyboardViewController(keyboardViewController: KeyboardViewController) {
        self.keyboardViewControllers.remove(keyboardViewController)
        self.synchronize()
    }

    // # KeyboardSuggestionModel
    internal func registerSuggestionModel(suggestionModel: KeyboardSuggestionModel) {
        self.suggestionModels.insert(suggestionModel)
        self.synchronize()
    }

    internal func unregisterSuggestionModel(suggestionModel: KeyboardSuggestionModel) {
        self.suggestionModels.remove(suggestionModel)
        self.synchronize()
    }

    // # Synchonization
    private func synchronize() {
        let keyboardViewController = self.keyboardViewControllers.first

        for suggestionModel in self.suggestionModels {
            suggestionModel.keyboardViewController = keyboardViewController
        }
    }
}