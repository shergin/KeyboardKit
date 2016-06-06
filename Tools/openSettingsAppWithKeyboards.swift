//
//  openSettingsAppWithKeyboards.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 5/16/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation


public func openSettingsAppWithKeyboards() {
    // Original URL: "prefs:root=General&path=Keyboard/KEYBOARDS"
    let parts = ["prefs", ":", "root", "=", "General", "&", "path", "=", "Keyboard", "/", "KEYBOARDS"]

    if let settingsURL = NSURL(string: parts.joinWithSeparator("")) {
        if (UIApplication.sharedApplication().openURL(settingsURL)) {
            // Successfully open internal Keyboard Settings screen.
            return
        }
    }

    UIApplication.sharedApplication().openURL(NSURL(string: UIApplicationOpenSettingsURLString)!)
}
