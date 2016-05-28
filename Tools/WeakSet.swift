//
//  WeakSet.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 2/5/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation

internal struct WeakBox<T: AnyObject> {
    internal private(set) weak var value: T?
    private var pointer: UnsafePointer<Void>
    internal init(_ value: T) {
        self.value = value
        self.pointer = unsafeAddressOf(value)
    }
}


extension WeakBox: Hashable {
    var hashValue: Int {
        return self.pointer.hashValue
    }
}


extension WeakBox: Equatable {}

func ==<T>(lhs: WeakBox<T>, rhs: WeakBox<T>) -> Bool {
    return lhs.pointer == rhs.pointer
}



public struct WeakSet<Element>: SequenceType {
    private var boxes = Set<WeakBox<AnyObject>>()

    public init() {}

    private mutating func sanitaze() {
        for box in self.boxes {
            if box.value == nil {
                boxes.remove(box)
            }
        }
    }

    public mutating func insert(member: Element) {
        guard let object = member as? AnyObject else {
            fatalError("WeakSet's member (\(member)) must conform to AnyObject protocol.")
        }

        self.boxes.insert(WeakBox(object))
    }

    public mutating func remove(member: Element) {
        guard let object = member as? AnyObject else {
            fatalError("WeakSet's member (\(member)) must conform to AnyObject protocol.")
        }

        self.boxes.remove(WeakBox(object))
    }

    public mutating func removeAll() {
        self.boxes.removeAll()
    }

    public func contains(member: Element) -> Bool {
        guard let object = member as? AnyObject else {
            fatalError("WeakSet's member (\(member)) must conform to AnyObject protocol.")
        }

        return self.boxes.contains(WeakBox(object))
    }

    public func generate() -> AnyGenerator<Element> {
        var generator = self.boxes.generate()

        return AnyGenerator {
            while(true) {
                guard let box = generator.next() else {
                    return nil
                }

                guard let element = box.value else {
                    continue
                }

                return element as? Element
            }
        }
    }
}

/*
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
*/