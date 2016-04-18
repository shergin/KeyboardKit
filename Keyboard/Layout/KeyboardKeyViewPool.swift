//
//  KeyboardKeyViewPool.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 1/13/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation

typealias KeyViewAndKeyTypeTuple = (keyView: KeyboardKeyView, keyType: KeyboardKeyType)

public final class KeyboardKeyViewPool {

    private var viewsBySize: [CGSize: [KeyViewAndKeyTypeTuple]] = [:]

    public func store(keyView keyView: KeyboardKeyView, keyType: KeyboardKeyType) {
        let size = keyView.frame.size

        if self.viewsBySize[size] == nil {
            self.viewsBySize[size] = []
        }

        self.viewsBySize[size]!.append((keyView: keyView, keyType: keyType))
    }

    public func restore(size size: CGSize, keyType: KeyboardKeyType) -> KeyboardKeyView? {
        guard var tuples = self.viewsBySize[size] else {
            return nil
        }

        for i in 0..<tuples.count {
            let tuple = tuples[i]
            if tuple.keyType == keyType {
                // TODO: REWRITE IT!
                self.viewsBySize[size]!.removeAtIndex(i)
                tuples.removeAtIndex(i)
                /*
                if tuples.count == 0 {
                    self.viewsBySize.removeValueForKey(size)
                }
                */
                return tuple.keyView
            }
        }

        return nil
    }

    public var keyViews: [KeyboardKeyView] {
        return Array(self.viewsBySize.values.flatten().map { (tuple: KeyViewAndKeyTypeTuple) in
            return tuple.keyView
        })
    }

}
