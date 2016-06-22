//
//  KeyboardKeyBackspaceSymbolView.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 1/12/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import UIKit


public final class KeyboardKeyBackspaceSymbolView: KeyboardKeyDrawableSymbolView {
    public override func draw() {
        let color = self.tintColor

        let backspaceNormalPath = UIBezierPath()
        backspaceNormalPath.moveToPoint(CGPoint(x: -1.5, y: -4))
        backspaceNormalPath.addLineToPoint(CGPoint(x: -2.5, y: -3))
        backspaceNormalPath.addLineToPoint(CGPoint(x: 0.5, y: 0))
        backspaceNormalPath.addLineToPoint(CGPoint(x: -2.5, y: 3))
        backspaceNormalPath.addLineToPoint(CGPoint(x: -1.5, y: 4))
        backspaceNormalPath.addLineToPoint(CGPoint(x: 1.5, y: 1))
        backspaceNormalPath.addLineToPoint(CGPoint(x: 4.5, y: 4))
        backspaceNormalPath.addLineToPoint(CGPoint(x: 5.5, y: 3))
        backspaceNormalPath.addLineToPoint(CGPoint(x: 2.5, y: 0))
        backspaceNormalPath.addLineToPoint(CGPoint(x: 5.5, y: -3))
        backspaceNormalPath.addLineToPoint(CGPoint(x: 4.5, y: -4))
        backspaceNormalPath.addLineToPoint(CGPoint(x: 1.5, y: -1))
        backspaceNormalPath.addLineToPoint(CGPoint(x: -1.5, y: -4))
        backspaceNormalPath.closePath()
        backspaceNormalPath.moveToPoint(CGPoint(x: 5.94, y: -7))
        backspaceNormalPath.addLineToPoint(CGPoint(x: -2.5, y: -7))
        backspaceNormalPath.addLineToPoint(CGPoint(x: -4, y: -6.5))
        backspaceNormalPath.addLineToPoint(CGPoint(x: -10.5, y: 0))
        backspaceNormalPath.addLineToPoint(CGPoint(x: -4, y: 6.5))
        backspaceNormalPath.addLineToPoint(CGPoint(x: -2.5, y: 7))
        backspaceNormalPath.addLineToPoint(CGPoint(x: 5.94, y: 7))
        backspaceNormalPath.addCurveToPoint(CGPoint(x: 7.74, y: 6.85), controlPoint1: CGPoint(x: 6.82, y: 7), controlPoint2: CGPoint(x: 7.26, y: 7))
        backspaceNormalPath.addCurveToPoint(CGPoint(x: 8.85, y: 5.74), controlPoint1: CGPoint(x: 8.25, y: 6.66), controlPoint2: CGPoint(x: 8.66, y: 6.25))
        backspaceNormalPath.addCurveToPoint(CGPoint(x: 9, y: 3.94), controlPoint1: CGPoint(x: 9, y: 5.26), controlPoint2: CGPoint(x: 9, y: 4.82))
        backspaceNormalPath.addLineToPoint(CGPoint(x: 9, y: -3.94))
        backspaceNormalPath.addCurveToPoint(CGPoint(x: 8.85, y: -5.74), controlPoint1: CGPoint(x: 9, y: -4.82), controlPoint2: CGPoint(x: 9, y: -5.26))
        backspaceNormalPath.addCurveToPoint(CGPoint(x: 7.74, y: -6.85), controlPoint1: CGPoint(x: 8.66, y: -6.25), controlPoint2: CGPoint(x: 8.25, y: -6.66))
        backspaceNormalPath.addCurveToPoint(CGPoint(x: 5.94, y: -7), controlPoint1: CGPoint(x: 7.26, y: -7), controlPoint2: CGPoint(x: 6.82, y: -7))
        backspaceNormalPath.closePath()
        backspaceNormalPath.moveToPoint(CGPoint(x: -3.5, y: -8.5))
        backspaceNormalPath.addCurveToPoint(CGPoint(x: 5.87, y: -8.5), controlPoint1: CGPoint(x: -3.5, y: -8.5), controlPoint2: CGPoint(x: 5.87, y: -8.5))
        backspaceNormalPath.addCurveToPoint(CGPoint(x: 8.49, y: -8.3), controlPoint1: CGPoint(x: 7.23, y: -8.5), controlPoint2: CGPoint(x: 7.89, y: -8.5))
        backspaceNormalPath.addLineToPoint(CGPoint(x: 8.61, y: -8.28))
        backspaceNormalPath.addCurveToPoint(CGPoint(x: 10.28, y: -6.61), controlPoint1: CGPoint(x: 9.38, y: -7.99), controlPoint2: CGPoint(x: 9.99, y: -7.38))
        backspaceNormalPath.addCurveToPoint(CGPoint(x: 10.5, y: -3.91), controlPoint1: CGPoint(x: 10.5, y: -5.89), controlPoint2: CGPoint(x: 10.5, y: -5.23))
        backspaceNormalPath.addLineToPoint(CGPoint(x: 10.5, y: 3.91))
        backspaceNormalPath.addCurveToPoint(CGPoint(x: 10.3, y: 6.49), controlPoint1: CGPoint(x: 10.5, y: 5.23), controlPoint2: CGPoint(x: 10.5, y: 5.89))
        backspaceNormalPath.addLineToPoint(CGPoint(x: 10.28, y: 6.61))
        backspaceNormalPath.addCurveToPoint(CGPoint(x: 8.61, y: 8.28), controlPoint1: CGPoint(x: 9.99, y: 7.38), controlPoint2: CGPoint(x: 9.38, y: 7.99))
        backspaceNormalPath.addCurveToPoint(CGPoint(x: 5.91, y: 8.5), controlPoint1: CGPoint(x: 7.89, y: 8.5), controlPoint2: CGPoint(x: 7.23, y: 8.5))
        backspaceNormalPath.addLineToPoint(CGPoint(x: -3.5, y: 8.5))
        backspaceNormalPath.addLineToPoint(CGPoint(x: -5, y: 8))
        backspaceNormalPath.addLineToPoint(CGPoint(x: -12.5, y: 0.5))
        backspaceNormalPath.addLineToPoint(CGPoint(x: -12.5, y: -0.5))
        backspaceNormalPath.addLineToPoint(CGPoint(x: -5, y: -8))
        backspaceNormalPath.addLineToPoint(CGPoint(x: -3.5, y: -8.5))
        backspaceNormalPath.closePath()
        color.setFill()
        backspaceNormalPath.fill()
    }
}
