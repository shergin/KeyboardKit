//
//  NSCharacterSet+Separators.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 4/19/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation


private let cachedSeparatorChracterSet: NSCharacterSet = {
    var characterSet = NSMutableCharacterSet()
    characterSet.formUnionWithCharacterSet(NSCharacterSet.whitespaceCharacterSet())
    characterSet.formUnionWithCharacterSet(NSCharacterSet.newlineCharacterSet())
    characterSet.formUnionWithCharacterSet(NSCharacterSet.punctuationCharacterSet())
    characterSet.formUnionWithCharacterSet(NSCharacterSet.controlCharacterSet())
    return characterSet
} ()



extension NSCharacterSet {
    static func separatorChracterSet() -> NSCharacterSet {
        return cachedSeparatorChracterSet
    }
}