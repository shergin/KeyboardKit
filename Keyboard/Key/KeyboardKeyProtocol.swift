//
//  KeyboardKeyProtocol.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 1/12/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation

// popup constraints have to be setup with the topmost view in mind; hence these callbacks
protocol KeyboardKeyProtocol: class {
    func frameForPopup(key: KeyboardKeyView, direction: KeyboardDirection) -> CGRect
    func willShowPopup(key: KeyboardKeyView, direction: KeyboardDirection) //may be called multiple times during layout
    func willHidePopup(key: KeyboardKeyView)
}
