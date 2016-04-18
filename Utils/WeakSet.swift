//
//  WeakSet.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 2/5/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation


internal final class WeakSet<ObjectType>: SequenceType {

    var count: Int {
        return weakStorage.count
    }

    private let weakStorage = NSHashTable.weakObjectsHashTable()

    func addObject(object: ObjectType) {
        guard object is AnyObject else {
            fatalError("Object (\(object)) should be subclass of AnyObject")
        }

        weakStorage.addObject(object as? AnyObject)
    }

    func removeObject(object: ObjectType) {
        guard object is AnyObject else {
            fatalError("Object (\(object)) should be subclass of AnyObject")
        }

        weakStorage.removeObject(object as? AnyObject)
    }

    func removeAllObjects() {
        weakStorage.removeAllObjects()
    }

    func containsObject(object: ObjectType) -> Bool {
        guard object is AnyObject else {
            fatalError("Object (\(object)) should be subclass of AnyObject")
        }

        return weakStorage.containsObject(object as? AnyObject)
    }

    func generate() -> AnyGenerator<ObjectType> {
        let enumerator = weakStorage.objectEnumerator()

        return anyGenerator {
            return enumerator.nextObject() as! ObjectType?
        }
    }
}
