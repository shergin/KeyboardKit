//
//  KeyboardSuggestionGuessesSortingModel.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 4/8/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation


extension String {
    internal var unify: String {
        return self.lowercaseString
    }

    internal var simplify: String {
        return self
            .stringByReplacingOccurrencesOfString("'", withString: "")
            .stringByReplacingOccurrencesOfString(" ", withString: "")
    }
}


internal final class KeyboardSuggestionGuessesSortingModel {
    public weak var keyboardViewController: KeyboardViewController?

    private var keyViewSetHashValue: Int = 0
    private var keyTable: [String: KeyboardSuggestionKey] = [:]

    private func updateKeysIfNeeded() {
        guard let keyboardViewController = self.keyboardViewController else {
            return
        }

        let keyViewSet = keyboardViewController.keyViewSet

        guard self.keyViewSetHashValue != keyViewSet.hashValue else {
            return
        }

        self.keyTable.removeAll()

        for (key, keyView) in keyViewSet {
            guard let output = key.output else {
                continue
            }

            let unifiedOutput = output.lowercase.unify

            self.keyTable[unifiedOutput] = KeyboardSuggestionKey(output: unifiedOutput, frame: keyView.frame)
        }

        self.keyViewSetHashValue = keyViewSet.hashValue
    }

    private func keyStreamForString(string: String) -> KeyboardSuggestionKeyStream {
        let keys: [KeyboardSuggestionKey?] = string.simplify.characters.map { character in
            let output = String(character).unify
            return self.keyTable[output]
        }

        return KeyboardSuggestionKeyStream(
            source: string,
            keys: keys,
            score: .infinity
        )
    }

    internal func sortReplacements(replacements: [String], placement: String) -> [String] {
        self.updateKeysIfNeeded()

        let sourceStream = self.keyStreamForString(placement)
        var guesseStreams = replacements.map { self.keyStreamForString($0) }

        let sourceKeys = sourceStream.keys

        for (index, guessStream) in guesseStreams.enumerate() {
            if guessStream.keys.count != sourceKeys.count {
                continue
            }

            var distance: CGFloat = 0.0

            for i in 0..<sourceKeys.count {
                guard let sourceKey = sourceKeys[i] else {
                    continue
                }

                guard let guessKey = guessStream.keys[i] else {
                    continue
                }

                guard sourceKey.output != guessKey.output else {
                    continue
                }

                distance += (sourceKey.center - guessKey.center).length()
            }

            guesseStreams[index].score = Double(distance)
        }

        guesseStreams.sortInPlace { (left, right) -> Bool in
            left.score < right.score
        }

        return guesseStreams.map { $0.source }
    }

}
