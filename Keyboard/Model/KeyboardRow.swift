//
//  KeyboardRow.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 1/13/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation

typealias KeyboardRow = Array<KeyboardKey>

extension CollectionType where Generator.Element == KeyboardKey, Self.Index == Int {

    func isCharacterRowHeuristic() -> Bool {
        return
            self.count >= 1 &&
            self[0].type.isCharacter
    }

    func isDoubleSidedRowHeuristic() -> Bool {
        return
            self.count >= 3 &&
            !self[0].type.isCharacter &&
            self[1].type.isCharacter
    }

}
