//
//  KeyboardKeyEmojiSymbolView.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 2/26/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation


public final class KeyboardKeyEmojiSymbolView: KeyboardKeySymbolView {

    public override class func symbolPath() -> UIBezierPath! {
        let emojiPath = UIBezierPath()
        emojiPath.moveToPoint(CGPointMake(-0.25, 9.5))
        emojiPath.addCurveToPoint(CGPointMake(9.5, -0.25), controlPoint1: CGPointMake(5.13, 9.5), controlPoint2: CGPointMake(9.5, 5.13))
        emojiPath.addCurveToPoint(CGPointMake(-0.25, -10), controlPoint1: CGPointMake(9.5, -5.63), controlPoint2: CGPointMake(5.13, -10))
        emojiPath.addCurveToPoint(CGPointMake(-10, -0.25), controlPoint1: CGPointMake(-5.63, -10), controlPoint2: CGPointMake(-10, -5.63))
        emojiPath.addCurveToPoint(CGPointMake(-0.25, 9.5), controlPoint1: CGPointMake(-10, 5.13), controlPoint2: CGPointMake(-5.63, 9.5))
        emojiPath.closePath()
        emojiPath.moveToPoint(CGPointMake(-0.25, 8.5))
        emojiPath.addCurveToPoint(CGPointMake(8.5, -0.25), controlPoint1: CGPointMake(4.58, 8.5), controlPoint2: CGPointMake(8.5, 4.58))
        emojiPath.addCurveToPoint(CGPointMake(-0.25, -9), controlPoint1: CGPointMake(8.5, -5.08), controlPoint2: CGPointMake(4.58, -9))
        emojiPath.addCurveToPoint(CGPointMake(-9, -0.25), controlPoint1: CGPointMake(-5.08, -9), controlPoint2: CGPointMake(-9, -5.08))
        emojiPath.addCurveToPoint(CGPointMake(-0.25, 8.5), controlPoint1: CGPointMake(-9, 4.58), controlPoint2: CGPointMake(-5.08, 8.5))
        emojiPath.closePath()
        emojiPath.moveToPoint(CGPointMake(-3.25, -2))
        emojiPath.addCurveToPoint(CGPointMake(-2, -3.25), controlPoint1: CGPointMake(-2.56, -2), controlPoint2: CGPointMake(-2, -2.56))
        emojiPath.addCurveToPoint(CGPointMake(-3.25, -4.5), controlPoint1: CGPointMake(-2, -3.94), controlPoint2: CGPointMake(-2.56, -4.5))
        emojiPath.addCurveToPoint(CGPointMake(-4.5, -3.25), controlPoint1: CGPointMake(-3.94, -4.5), controlPoint2: CGPointMake(-4.5, -3.94))
        emojiPath.addCurveToPoint(CGPointMake(-3.25, -2), controlPoint1: CGPointMake(-4.5, -2.56), controlPoint2: CGPointMake(-3.94, -2))
        emojiPath.closePath()
        emojiPath.moveToPoint(CGPointMake(2.75, -2))
        emojiPath.addCurveToPoint(CGPointMake(4, -3.25), controlPoint1: CGPointMake(3.44, -2), controlPoint2: CGPointMake(4, -2.56))
        emojiPath.addCurveToPoint(CGPointMake(2.75, -4.5), controlPoint1: CGPointMake(4, -3.94), controlPoint2: CGPointMake(3.44, -4.5))
        emojiPath.addCurveToPoint(CGPointMake(1.5, -3.25), controlPoint1: CGPointMake(2.06, -4.5), controlPoint2: CGPointMake(1.5, -3.94))
        emojiPath.addCurveToPoint(CGPointMake(2.75, -2), controlPoint1: CGPointMake(1.5, -2.56), controlPoint2: CGPointMake(2.06, -2))
        emojiPath.closePath()
        emojiPath.moveToPoint(CGPointMake(-7.11, 1.16))
        emojiPath.addCurveToPoint(CGPointMake(-6.15, 0.23), controlPoint1: CGPointMake(-7.36, 0.38), controlPoint2: CGPointMake(-6.93, -0.02))
        emojiPath.addCurveToPoint(CGPointMake(-0.25, 1.21), controlPoint1: CGPointMake(-6.15, 0.23), controlPoint2: CGPointMake(-3.91, 1.21))
        emojiPath.addCurveToPoint(CGPointMake(5.65, 0.23), controlPoint1: CGPointMake(3.41, 1.21), controlPoint2: CGPointMake(5.65, 0.23))
        emojiPath.addCurveToPoint(CGPointMake(6.61, 1.18), controlPoint1: CGPointMake(6.43, -0.03), controlPoint2: CGPointMake(6.88, 0.4))
        emojiPath.addCurveToPoint(CGPointMake(-0.25, 6.58), controlPoint1: CGPointMake(6.61, 1.18), controlPoint2: CGPointMake(5.6, 6.58))
        emojiPath.addCurveToPoint(CGPointMake(-7.11, 1.16), controlPoint1: CGPointMake(-6.1, 6.58), controlPoint2: CGPointMake(-7.11, 1.16))
        emojiPath.closePath()
        emojiPath.moveToPoint(CGPointMake(-0.25, 2.19))
        emojiPath.addCurveToPoint(CGPointMake(-5.15, 1.47), controlPoint1: CGPointMake(-2.93, 2.19), controlPoint2: CGPointMake(-5.15, 1.47))
        emojiPath.addCurveToPoint(CGPointMake(-5.44, 1.96), controlPoint1: CGPointMake(-5.67, 1.33), controlPoint2: CGPointMake(-5.82, 1.57))
        emojiPath.addCurveToPoint(CGPointMake(-0.25, 3.65), controlPoint1: CGPointMake(-5.44, 1.96), controlPoint2: CGPointMake(-4.64, 3.65))
        emojiPath.addCurveToPoint(CGPointMake(4.95, 1.94), controlPoint1: CGPointMake(4.14, 3.65), controlPoint2: CGPointMake(4.95, 1.94))
        emojiPath.addCurveToPoint(CGPointMake(4.64, 1.48), controlPoint1: CGPointMake(5.31, 1.54), controlPoint2: CGPointMake(5.17, 1.34))
        emojiPath.addCurveToPoint(CGPointMake(-0.25, 2.19), controlPoint1: CGPointMake(4.64, 1.48), controlPoint2: CGPointMake(2.43, 2.19))
        emojiPath.closePath()
        emojiPath.usesEvenOddFillRule = true

        return emojiPath
    }

}