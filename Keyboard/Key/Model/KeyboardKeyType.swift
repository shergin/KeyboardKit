//
//  KeyboardKeyType.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 1/12/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//


public enum KeyboardKeyType: RawRepresentable {
    public typealias RawValue = Int

    case Character
    case Shift
    case Backspace
    case AdvanceToNextInputMode
    case Period
    case Space
    case Return
    case Settings
    case Other
    case PageChange(pageNumber: Int)

    public init?(rawValue: RawValue) {
        if rawValue < 100 {
            switch rawValue {
            case 0: self = .Character; break
            case 1: self = .Shift; break
            case 2: self = .Backspace; break
            case 3: self = .AdvanceToNextInputMode; break
            case 4: self = .Period; break
            case 5: self = .Space; break
            case 6: self = .Return; break
            case 7: self = .Settings; break
            case 8: self = .Other; break
            default:
                return nil
            }
        }

        self = .PageChange(pageNumber: rawValue - 100)
    }

    public var rawValue: RawValue {
        switch self {
        case .Character: return 0
        case .Shift: return 1
        case .Backspace: return 2
        case .AdvanceToNextInputMode: return 3
        case .Period: return 4
        case .Space: return 5
        case .Return: return 6
        case .Settings: return 7
        case .Other: return 8
        case .PageChange(let pageNumber): return pageNumber + 100
        }
    }
}


extension KeyboardKeyType: Hashable {
    public var hashValue: Int {
        return self.rawValue
    }
}


public extension KeyboardKeyType {

    static func typeFromCharacter(character: Swift.Character) -> KeyboardKeyType {
        switch character {
        case ".":
            return .Period
        case " ":
            return .Space
        case "\n":
            return .Return
        default:
            return .Character
        }
    }

    public var isSpecial: Bool {
        get {
            switch self {
            case .Shift:
                return true
            case .Backspace:
                return true
            case .PageChange:
                return true
            case .AdvanceToNextInputMode:
                return true
            case .Return:
                return true
            case .Settings:
                return true
            default:
                return false
            }
        }
    }

    public func suitableColorType() -> KeyboardKeyColorType {
        return self.isSpecial ? .Special : .Regular
    }

    public var isCharacter: Bool {
        get {
            switch self {
            case
            .Character,
            .Period:
                return true
            default:
                return false
            }
        }
    }

    public var isCharacterOrSomethingLikeThis: Bool {
        get {
            switch self {
            case
            .Character,
            .Period,
            .Return,
            .Space:
                return true
            default:
                return false
            }
        }
    }
}
