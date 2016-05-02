//
//  UIApplication+sharedKeyboardApplication.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 2/5/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import UIKit


extension UIApplication {

    public static func 🚀sharedApplication() -> UIApplication {
        guard UIApplication.respondsToSelector("sharedApplication") else {
            fatalError("UIApplication.sharedKeyboardApplication(): `UIApplication` does not respond to selector `sharedApplication`.")
        }

        guard let unmanagedSharedApplication = UIApplication.performSelector("sharedApplication") else {
            fatalError("UIApplication.sharedKeyboardApplication(): `UIApplication.sharedApplication()` returned `nil`.")
        }

        guard let sharedApplication = unmanagedSharedApplication.takeUnretainedValue() as? UIApplication else {
            fatalError("UIApplication.sharedKeyboardApplication(): `UIApplication.sharedApplication()` returned not `UIApplication` instance.")
        }

        return sharedApplication
    }

}

extension UIApplication {

    public func 🚀openURL(url: NSURL) -> Bool {
        return self.performSelector("openURL:", withObject: url) != nil
    }
    
}
