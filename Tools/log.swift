//
//  log.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 5/11/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation


internal func log<T>(argument: T, file: String = __FILE__, line: Int = __LINE__, function: String = __FUNCTION__) {
    guard _isDebugAssertConfiguration() else {
        return
    }

    let fileName = NSURL(fileURLWithPath: file, isDirectory: false).URLByDeletingPathExtension?.lastPathComponent ?? "Unknown"

    print("KeyboardKit/\(fileName)@\(line): \(argument)")
}
