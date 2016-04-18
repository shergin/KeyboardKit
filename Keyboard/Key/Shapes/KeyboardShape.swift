//
//  KeyboardShape.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 1/19/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation


internal class KeyboardShape {
    internal var fillPath: UIBezierPath = UIBezierPath()
    internal var underPath: UIBezierPath = UIBezierPath()
    internal var edgePath: UIBezierPath = UIBezierPath()
    internal var edgePaths: [UIBezierPath] = []

    internal var hasUnderPath: Bool { return true }

    internal var needRecreatePaths: Bool = true

    internal var bounds: CGRect = CGRectZero {
        didSet {
            if oldValue != self.bounds {
                self.needRecreatePaths = true
            }
        }
    }

    internal var cornerRadius: CGFloat = 0
    internal var underOffset: CGPoint = CGPointZero

    internal init() {
        // FIXME: Use some style source!
        self.cornerRadius = 4
        self.underOffset = CGPoint(x: 0, y: 1)
    }

    internal convenience init(shape: KeyboardShape) {
        self.init()

        self.cornerRadius = shape.cornerRadius
        self.underOffset = shape.underOffset
    }

    internal convenience init(shapes: [KeyboardShape?]) {
        self.init()

        for shape in shapes {
            if let shape = shape {
                self.fillPath.appendPath(shape.fillPath)
                self.underPath.appendPath(shape.underPath)
                self.edgePath.appendPath(shape.edgePath)
                self.edgePaths.appendContentsOf(shape.edgePaths)
            }
        }
    }

    internal func createPathsIfNeeded() {
        //if self.needRecreatePaths {
            self.createPaths()
        //}
    }

    internal func createPaths() {
        self.needRecreatePaths = false
    }
}
