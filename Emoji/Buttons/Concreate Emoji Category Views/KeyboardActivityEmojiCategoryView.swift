//
//  KeyboardActivityEmojiCategoryView.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 5/31/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import UIKit


public final class KeyboardActivityEmojiCategoryView: KeyboardEmojiCategoryView {

    public override var emojiCategory: KeyboardEmojiCategory {
        return .Activity
    }

    internal override func draw() {
        super.draw()

        let color = self.tintColor

        let ballPath = UIBezierPath()
        ballPath.moveToPoint(CGPointMake(3.98, 6.04))
        ballPath.addLineToPoint(CGPointMake(3.98, 2.9))
        ballPath.addLineToPoint(CGPointMake(4.99, 0.94))
        ballPath.addLineToPoint(CGPointMake(7.18, 0.79))
        ballPath.addCurveToPoint(CGPointMake(3.98, 6.04), controlPoint1: CGPointMake(6.94, 2.98), controlPoint2: CGPointMake(5.72, 4.88))
        ballPath.addLineToPoint(CGPointMake(3.98, 6.04))
        ballPath.closePath()
        ballPath.moveToPoint(CGPointMake(-2.76, 6.7))
        ballPath.addLineToPoint(CGPointMake(-2.76, 5.93))
        ballPath.addLineToPoint(CGPointMake(-1.67, 5.89))
        ballPath.addLineToPoint(CGPointMake(0.08, 6.79))
        ballPath.addLineToPoint(CGPointMake(0.08, 7.25))
        ballPath.addCurveToPoint(CGPointMake(-0.01, 7.25), controlPoint1: CGPointMake(0.05, 7.25), controlPoint2: CGPointMake(0.02, 7.25))
        ballPath.addCurveToPoint(CGPointMake(-2.76, 6.7), controlPoint1: CGPointMake(-0.99, 7.25), controlPoint2: CGPointMake(-1.91, 7.05))
        ballPath.addLineToPoint(CGPointMake(-2.76, 6.7))
        ballPath.closePath()
        ballPath.moveToPoint(CGPointMake(-5.87, 4.24))
        ballPath.addLineToPoint(CGPointMake(-4.83, 3.89))
        ballPath.addLineToPoint(CGPointMake(-3.51, 5.46))
        ballPath.addLineToPoint(CGPointMake(-3.51, 6.34))
        ballPath.addCurveToPoint(CGPointMake(-5.87, 4.24), controlPoint1: CGPointMake(-4.44, 5.83), controlPoint2: CGPointMake(-5.25, 5.1))
        ballPath.addLineToPoint(CGPointMake(-5.87, 4.24))
        ballPath.closePath()
        ballPath.moveToPoint(CGPointMake(-7.15, -1.15))
        ballPath.addLineToPoint(CGPointMake(-5.1, -1.84))
        ballPath.addLineToPoint(CGPointMake(-4.51, -1.13))
        ballPath.addLineToPoint(CGPointMake(-4.51, 3))
        ballPath.addLineToPoint(CGPointMake(-6.29, 3.59))
        ballPath.addCurveToPoint(CGPointMake(-7.25, 0), controlPoint1: CGPointMake(-6.9, 2.53), controlPoint2: CGPointMake(-7.25, 1.31))
        ballPath.addCurveToPoint(CGPointMake(-7.15, -1.15), controlPoint1: CGPointMake(-7.25, -0.39), controlPoint2: CGPointMake(-7.21, -0.78))
        ballPath.addLineToPoint(CGPointMake(-7.15, -1.15))
        ballPath.closePath()
        ballPath.moveToPoint(CGPointMake(-4.51, -5.67))
        ballPath.addLineToPoint(CGPointMake(-4.51, -3.96))
        ballPath.addLineToPoint(CGPointMake(-5.27, -2.57))
        ballPath.addLineToPoint(CGPointMake(-6.96, -2))
        ballPath.addCurveToPoint(CGPointMake(-4.51, -5.67), controlPoint1: CGPointMake(-6.54, -3.47), controlPoint2: CGPointMake(-5.67, -4.75))
        ballPath.addLineToPoint(CGPointMake(-4.51, -5.67))
        ballPath.closePath()
        ballPath.moveToPoint(CGPointMake(1.02, -7.17))
        ballPath.addLineToPoint(CGPointMake(1.04, -6.41))
        ballPath.addLineToPoint(CGPointMake(-2.16, -4.93))
        ballPath.addLineToPoint(CGPointMake(-3.76, -4.98))
        ballPath.addLineToPoint(CGPointMake(-3.76, -6))
        ballPath.addLineToPoint(CGPointMake(-4.07, -6))
        ballPath.addCurveToPoint(CGPointMake(-0.01, -7.25), controlPoint1: CGPointMake(-2.91, -6.79), controlPoint2: CGPointMake(-1.52, -7.25))
        ballPath.addCurveToPoint(CGPointMake(1.02, -7.17), controlPoint1: CGPointMake(0.34, -7.25), controlPoint2: CGPointMake(0.68, -7.22))
        ballPath.addLineToPoint(CGPointMake(1.02, -7.17))
        ballPath.closePath()
        ballPath.moveToPoint(CGPointMake(-3.76, -0.89))
        ballPath.addLineToPoint(CGPointMake(-1.8, -1.97))
        ballPath.addLineToPoint(CGPointMake(1.05, 0.25))
        ballPath.addLineToPoint(CGPointMake(1.05, 2.26))
        ballPath.addLineToPoint(CGPointMake(-1.64, 3.63))
        ballPath.addLineToPoint(CGPointMake(-3.76, 2.7))
        ballPath.addLineToPoint(CGPointMake(-3.76, -0.89))
        ballPath.closePath()
        ballPath.moveToPoint(CGPointMake(1.57, -5.83))
        ballPath.addLineToPoint(CGPointMake(3.23, -4.78))
        ballPath.addLineToPoint(CGPointMake(3.23, -1.23))
        ballPath.addLineToPoint(CGPointMake(1.39, -0.43))
        ballPath.addLineToPoint(CGPointMake(-1.63, -2.78))
        ballPath.addLineToPoint(CGPointMake(-1.61, -4.35))
        ballPath.addLineToPoint(CGPointMake(1.57, -5.83))
        ballPath.closePath()
        ballPath.moveToPoint(CGPointMake(2.86, 6.65))
        ballPath.addLineToPoint(CGPointMake(1.41, 6.64))
        ballPath.addLineToPoint(CGPointMake(-1.1, 5.34))
        ballPath.addLineToPoint(CGPointMake(-1.08, 4.19))
        ballPath.addLineToPoint(CGPointMake(1.65, 2.79))
        ballPath.addLineToPoint(CGPointMake(3.23, 3.24))
        ballPath.addLineToPoint(CGPointMake(3.23, 6.47))
        ballPath.addCurveToPoint(CGPointMake(2.86, 6.65), controlPoint1: CGPointMake(3.11, 6.53), controlPoint2: CGPointMake(2.99, 6.59))
        ballPath.addLineToPoint(CGPointMake(2.86, 6.65))
        ballPath.closePath()
        ballPath.moveToPoint(CGPointMake(7.22, 0))
        ballPath.addCurveToPoint(CGPointMake(7.22, 0.03), controlPoint1: CGPointMake(7.22, 0.01), controlPoint2: CGPointMake(7.22, 0.02))
        ballPath.addLineToPoint(CGPointMake(5.02, 0.19))
        ballPath.addLineToPoint(CGPointMake(3.98, -0.94))
        ballPath.addLineToPoint(CGPointMake(3.98, -4.78))
        ballPath.addLineToPoint(CGPointMake(5.1, -5.13))
        ballPath.addCurveToPoint(CGPointMake(7.22, 0), controlPoint1: CGPointMake(6.41, -3.81), controlPoint2: CGPointMake(7.22, -2))
        ballPath.addLineToPoint(CGPointMake(7.22, 0))
        ballPath.closePath()
        ballPath.moveToPoint(CGPointMake(-0.01, -8))
        ballPath.addCurveToPoint(CGPointMake(-7.81, -1.72), controlPoint1: CGPointMake(-3.83, -8), controlPoint2: CGPointMake(-7.02, -5.31))
        ballPath.addLineToPoint(CGPointMake(-7.84, -1.71))
        ballPath.addLineToPoint(CGPointMake(-7.83, -1.66))
        ballPath.addCurveToPoint(CGPointMake(-8, 0), controlPoint1: CGPointMake(-7.94, -1.13), controlPoint2: CGPointMake(-8, -0.57))
        ballPath.addCurveToPoint(CGPointMake(-6.68, 4.4), controlPoint1: CGPointMake(-8, 1.63), controlPoint2: CGPointMake(-7.51, 3.14))
        ballPath.addLineToPoint(CGPointMake(-6.65, 4.5))
        ballPath.addLineToPoint(CGPointMake(-6.62, 4.49))
        ballPath.addCurveToPoint(CGPointMake(-0.01, 8), controlPoint1: CGPointMake(-5.19, 6.61), controlPoint2: CGPointMake(-2.76, 8))
        ballPath.addCurveToPoint(CGPointMake(7.97, 0), controlPoint1: CGPointMake(4.4, 8), controlPoint2: CGPointMake(7.97, 4.42))
        ballPath.addCurveToPoint(CGPointMake(-0.01, -8), controlPoint1: CGPointMake(7.97, -4.42), controlPoint2: CGPointMake(4.4, -8))
        ballPath.addLineToPoint(CGPointMake(-0.01, -8))
        ballPath.closePath()
        ballPath.usesEvenOddFillRule = true
        color.setFill()
        ballPath.fill()
    }
    
}
