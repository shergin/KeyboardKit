//
//  KeyboardKey.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 1/12/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation

private var keyboardKeyHashValueCounter = 0


public struct KeyboardKey {
    public var type: KeyboardKeyType = .Character
    public var colorType: KeyboardKeyColorType = .Regular

    public var label: KeyboardKeyLabel?
    public var image: KeyboardKeyImage?
    public var contentView: KeyboardKeyContentView?

    public var output: KeyboardKeyOutput?

    public var popupType: KeyboardKeyPopupType = .None

    public var alternateKeys: [KeyboardKey]?

    public var tag: Int = 0

    private var internalHashValue: Int
}

extension KeyboardKey {
    // # Initializers
    public init() {
        self.internalHashValue = keyboardKeyHashValueCounter
        keyboardKeyHashValueCounter += 1
    }

    public init(character: Character) {
        self.init()
        self.type = KeyboardKeyType.typeFromCharacter(character)
        self.setLetter(String(character))
        self.popupType = .Preview
        self.colorType = self.type.suitableColorType()
    }

    public init(type: KeyboardKeyType) {
        self.init()
        self.type = type
        self.image = KeyboardKeyImage(keyType: self.type)
        self.colorType = self.type.suitableColorType()
    }

    public init(character: Character, alternateCharacters: [Character]?) {
        self.init(character: character)

        if let alternateCharacters = alternateCharacters {
            var characters: [Character] = []
            characters.append(character)
            characters.appendContentsOf(alternateCharacters)
            self.alternateKeys = characters.map { KeyboardKey(character: $0) }
        }
    }

    // #
    public func hasOutput() -> Bool {
        return self.output != nil
    }

    public mutating func setLetter(letter: String) {
        self.output = KeyboardKeyOutput(automated: letter)
        self.label = KeyboardKeyLabel(automated: letter)
    }
}


extension KeyboardKey: Hashable {
    public var hashValue: Int { return self.internalHashValue }
}


extension KeyboardKey: Equatable {
}

public func ==(lhs: KeyboardKey, rhs: KeyboardKey) -> Bool {
    // FIXME: ADD ALL OF THEM!
    return
        lhs.hashValue == rhs.hashValue &&
        lhs.label == rhs.label
}
