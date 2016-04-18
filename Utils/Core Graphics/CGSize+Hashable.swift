//
//  CGSize+Hashable.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 1/12/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import UIKit

extension CGSize: Hashable {
    public var hashValue: Int {
        get {
            return (width.hashValue ^ height.hashValue)
        }
    }
}
