//
//  log.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 5/11/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation


internal func log<T>(argument: T, file: String = #file, line: Int = #line, function: String = #function) {
    guard _isDebugAssertConfiguration() else {
        return
    }

    let fileName = NSURL(fileURLWithPath: file, isDirectory: false).URLByDeletingPathExtension?.lastPathComponent ?? "Unknown"

    print("KeyboardKit/\(fileName)@\(line): \(argument)")
}
