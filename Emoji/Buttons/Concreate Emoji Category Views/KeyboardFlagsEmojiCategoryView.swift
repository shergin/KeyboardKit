//
//  KeyboardFlagsEmojiCategoryView.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 5/31/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import UIKit


public final class KeyboardFlagsEmojiCategoryView: KeyboardEmojiCategoryView {

    public override var emojiCategory: KeyboardEmojiCategory {
        return .Flags
    }

    internal override func draw() {
        super.draw()

        let color = self.tintColor

        let flagPath = UIBezierPath()
        flagPath.moveToPoint(CGPointMake(5.04, 0.12))
        flagPath.addCurveToPoint(CGPointMake(2.99, -0.47), controlPoint1: CGPointMake(4.45, -0.2), controlPoint2: CGPointMake(3.73, -0.47))
        flagPath.addCurveToPoint(CGPointMake(0.02, 0.34), controlPoint1: CGPointMake(2.01, -0.47), controlPoint2: CGPointMake(1, -0.06))
        flagPath.addCurveToPoint(CGPointMake(-1.76, 0.91), controlPoint1: CGPointMake(-0.63, 0.61), controlPoint2: CGPointMake(-1.37, 0.91))
        flagPath.addCurveToPoint(CGPointMake(-4, -0.01), controlPoint1: CGPointMake(-2.27, 0.91), controlPoint2: CGPointMake(-3.25, 0.44))
        flagPath.addLineToPoint(CGPointMake(-4, -5.62))
        flagPath.addCurveToPoint(CGPointMake(-1.76, -5.16), controlPoint1: CGPointMake(-3.31, -5.38), controlPoint2: CGPointMake(-2.47, -5.16))
        flagPath.addCurveToPoint(CGPointMake(0.73, -5.76), controlPoint1: CGPointMake(-0.98, -5.16), controlPoint2: CGPointMake(-0.15, -5.45))
        flagPath.addCurveToPoint(CGPointMake(2.99, -6.34), controlPoint1: CGPointMake(1.52, -6.05), controlPoint2: CGPointMake(2.34, -6.34))
        flagPath.addCurveToPoint(CGPointMake(5.04, -5.56), controlPoint1: CGPointMake(3.74, -6.34), controlPoint2: CGPointMake(4.56, -5.9))
        flagPath.addLineToPoint(CGPointMake(5.04, 0.12))
        flagPath.addLineToPoint(CGPointMake(5.04, 0.12))
        flagPath.closePath()
        flagPath.moveToPoint(CGPointMake(2.99, -7.28))
        flagPath.addCurveToPoint(CGPointMake(-1.76, -6.09), controlPoint1: CGPointMake(1.45, -7.28), controlPoint2: CGPointMake(-0.47, -6.09))
        flagPath.addCurveToPoint(CGPointMake(-4, -6.61), controlPoint1: CGPointMake(-2.45, -6.09), controlPoint2: CGPointMake(-3.33, -6.36))
        flagPath.addLineToPoint(CGPointMake(-4, -7.03))
        flagPath.addLineToPoint(CGPointMake(-5, -7.03))
        flagPath.addLineToPoint(CGPointMake(-5, 6.97))
        flagPath.addLineToPoint(CGPointMake(-4, 6.97))
        flagPath.addLineToPoint(CGPointMake(-4, 1.06))
        flagPath.addCurveToPoint(CGPointMake(-1.76, 1.84), controlPoint1: CGPointMake(-3.32, 1.44), controlPoint2: CGPointMake(-2.41, 1.84))
        flagPath.addCurveToPoint(CGPointMake(2.99, 0.47), controlPoint1: CGPointMake(-0.55, 1.84), controlPoint2: CGPointMake(1.49, 0.47))
        flagPath.addCurveToPoint(CGPointMake(5.98, 1.97), controlPoint1: CGPointMake(4.48, 0.47), controlPoint2: CGPointMake(5.98, 1.97))
        flagPath.addLineToPoint(CGPointMake(5.98, -6.03))
        flagPath.addCurveToPoint(CGPointMake(2.99, -7.28), controlPoint1: CGPointMake(5.98, -6.03), controlPoint2: CGPointMake(4.52, -7.28))
        flagPath.addLineToPoint(CGPointMake(2.99, -7.28))
        flagPath.closePath()
        flagPath.usesEvenOddFillRule = true
        color.setFill()
        flagPath.fill()
    }
    
}
