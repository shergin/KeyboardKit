//
//  KeyboardDirection.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 1/12/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation


public enum KeyboardDirection: Int {
    case Left = 0
    case Up = 1
    case Right = 2
    case Down = 3

    func clockwise() -> KeyboardDirection {
        switch self {
        case Left:
            return Up
        case Right:
            return Down
        case Up:
            return Right
        case Down:
            return Left
        }
    }

    func counterclockwise() -> KeyboardDirection {
        switch self {
        case Left:
            return Down
        case Right:
            return Up
        case Up:
            return Left
        case Down:
            return Right
        }
    }

    func opposite() -> KeyboardDirection {
        switch self {
        case Left:
            return Right
        case Right:
            return Left
        case Up:
            return Down
        case Down:
            return Up
        }
    }

    func horizontal() -> Bool {
        switch self {
        case
        Left,
        Right:
            return true
        default:
            return false
        }
    }
}


extension KeyboardDirection: CustomStringConvertible {
    public var description: String {
        get {
            switch self {
            case Left:
                return "Left"
            case Right:
                return "Right"
            case Up:
                return "Up"
            case Down:
                return "Down"
            }
        }
    }
}
