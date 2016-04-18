//
//  KeyboardKeyViewSet.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 1/13/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation


internal final class KeyboardKeyViewSet {

    private var viewsByKey: [KeyboardKey: KeyboardKeyView] = [:]
    private var keysByView: [KeyboardKeyView: KeyboardKey] = [:]

    internal var views: [KeyboardKeyView] {
        return Array(self.viewsByKey.values)
    }

    internal var keys: [KeyboardKey] {
        return Array(self.keysByView.values)
    }

    internal func insert(key: KeyboardKey, keyView: KeyboardKeyView) {
        self.viewsByKey[key] = keyView
        self.keysByView[keyView] = key
        self.touch()
    }

    internal func remove(key: KeyboardKey) {
        let keyView = self.viewsByKey[key]!
        self.viewsByKey.removeValueForKey(key)
        self.keysByView.removeValueForKey(keyView)
        self.touch()
    }

    internal func remove(keyView: KeyboardKeyView) {
        let key = self.keysByView[keyView]!
        self.viewsByKey.removeValueForKey(key)
        self.keysByView.removeValueForKey(keyView)
        self.touch()
    }

    internal func removeAll() {
        self.viewsByKey.removeAll()
        self.keysByView.removeAll()
        self.touch()
    }

    internal func viewByKey(key: KeyboardKey) -> KeyboardKeyView? {
        return self.viewsByKey[key]
    }

    internal func keyByView(keyView: KeyboardKeyView) -> KeyboardKey? {
        return self.keysByView[keyView]
    }

    private var internalHashValue: Int = 0
    private func touch() {
        self.internalHashValue += 1
    }
}


extension KeyboardKeyViewSet: SequenceType {
    internal func generate() -> DictionaryGenerator<KeyboardKey, KeyboardKeyView> {
        return self.viewsByKey.generate()
    }
}


extension KeyboardKeyViewSet: Hashable {
    internal var hashValue: Int {
        return self.internalHashValue
    }
}


extension KeyboardKeyViewSet: Equatable {
}

internal func ==(lhs: KeyboardKeyViewSet, rhs: KeyboardKeyViewSet) -> Bool {
    return
        lhs.viewsByKey == rhs.viewsByKey &&
        lhs.keysByView == rhs.keysByView
}


extension KeyboardKeyViewPool {

    internal func storeSet(keyViewSet: KeyboardKeyViewSet) {
        for (key, keyView) in keyViewSet {
            self.store(keyView: keyView, keyType: key.type)
        }
    }

}
