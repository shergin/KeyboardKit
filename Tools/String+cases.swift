//
//  String+cases.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 6/21/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation


extension String {
    func isCamelcase() -> Bool {
        return self.uppercaseString != self && self.lowercaseString != self
    }

    func isUppercase() -> Bool {
        return self.uppercaseString == self
    }

    func isLowercase() -> Bool {
        return self.lowercaseString == self
    }
}
