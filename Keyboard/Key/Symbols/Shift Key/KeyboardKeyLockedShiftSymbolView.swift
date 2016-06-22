//
//  KeyboardKeyLockedShiftSymbolView.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 6/20/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import UIKit


public final class KeyboardKeyLockedShiftSymbolView: KeyboardKeyDrawableSymbolView {
    override public func draw() {
        let color = self.tintColor
        let shiftLockedPath = UIBezierPath()
        shiftLockedPath.moveToPoint(CGPoint(x: -4.25, y: 9.75))
        shiftLockedPath.addLineToPoint(CGPoint(x: 4.25, y: 9.75))
        shiftLockedPath.addLineToPoint(CGPoint(x: 4.25, y: 7.25))
        shiftLockedPath.addLineToPoint(CGPoint(x: -4.25, y: 7.25))
        shiftLockedPath.addLineToPoint(CGPoint(x: -4.25, y: 9.75))
        shiftLockedPath.closePath()
        shiftLockedPath.moveToPoint(CGPoint(x: 0, y: -10))
        shiftLockedPath.addLineToPoint(CGPoint(x: 9.75, y: -0.25))
        shiftLockedPath.addLineToPoint(CGPoint(x: 4.25, y: -0.25))
        shiftLockedPath.addLineToPoint(CGPoint(x: 4.25, y: 4.75))
        shiftLockedPath.addLineToPoint(CGPoint(x: -4.25, y: 4.75))
        shiftLockedPath.addLineToPoint(CGPoint(x: -4.25, y: -0.25))
        shiftLockedPath.addLineToPoint(CGPoint(x: -9.75, y: -0.25))
        shiftLockedPath.addLineToPoint(CGPoint(x: 0, y: -10))
        shiftLockedPath.closePath()
        shiftLockedPath.lineJoinStyle = .Round
        color.setFill()
        shiftLockedPath.fill()
        color.setStroke()
        shiftLockedPath.lineWidth = 1.5
        shiftLockedPath.stroke()
    }
}
