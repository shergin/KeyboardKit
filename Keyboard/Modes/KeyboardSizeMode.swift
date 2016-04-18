//
//  KeyboardSizeMode.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 1/15/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import UIKit

public enum KeyboardSizeMode: Int {
    case Big // Like on iPad
    case Small // Like on iPhone
}


extension KeyboardSizeMode {
    static func suitable() -> KeyboardSizeMode {
        return UIDevice.currentDevice().userInterfaceIdiom == .Pad ? .Big : .Small
    }
}


