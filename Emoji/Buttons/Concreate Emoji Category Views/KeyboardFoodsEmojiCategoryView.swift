//
//  KeyboardFoodsEmojiCategoryView.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 5/31/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import UIKit


public final class KeyboardFoodEmojiCategoryView: KeyboardEmojiCategoryView {

    public override var emojiCategory: KeyboardEmojiCategory {
        return .Foods
    }

    override func draw() {
        let color = self.tintColor

        let foodPath = UIBezierPath()
        foodPath.moveToPoint(CGPointMake(5.93, -0.44))
        foodPath.addLineToPoint(CGPointMake(-3.96, -0.44))
        foodPath.addCurveToPoint(CGPointMake(-4.4, -1.18), controlPoint1: CGPointMake(-4.33, -0.44), controlPoint2: CGPointMake(-4.58, -0.84))
        foodPath.addCurveToPoint(CGPointMake(-1.26, -3.06), controlPoint1: CGPointMake(-3.8, -2.3), controlPoint2: CGPointMake(-2.62, -3.06))
        foodPath.addLineToPoint(CGPointMake(3.23, -3.06))
        foodPath.addCurveToPoint(CGPointMake(6.37, -1.18), controlPoint1: CGPointMake(4.59, -3.06), controlPoint2: CGPointMake(5.77, -2.3))
        foodPath.addCurveToPoint(CGPointMake(5.93, -0.44), controlPoint1: CGPointMake(6.55, -0.84), controlPoint2: CGPointMake(6.3, -0.44))
        foodPath.addLineToPoint(CGPointMake(5.93, -0.44))
        foodPath.closePath()
        foodPath.moveToPoint(CGPointMake(0.98, 2.5))
        foodPath.addLineToPoint(CGPointMake(-4.26, 0.5))
        foodPath.addLineToPoint(CGPointMake(6.23, 0.5))
        foodPath.addLineToPoint(CGPointMake(0.98, 2.5))
        foodPath.closePath()
        foodPath.moveToPoint(CGPointMake(6.23, 4))
        foodPath.addCurveToPoint(CGPointMake(5.73, 4.5), controlPoint1: CGPointMake(6.23, 4.28), controlPoint2: CGPointMake(6, 4.5))
        foodPath.addLineToPoint(CGPointMake(-3.76, 4.5))
        foodPath.addCurveToPoint(CGPointMake(-4.26, 4), controlPoint1: CGPointMake(-4.03, 4.5), controlPoint2: CGPointMake(-4.26, 4.28))
        foodPath.addLineToPoint(CGPointMake(-4.26, 3.13))
        foodPath.addCurveToPoint(CGPointMake(-4.13, 3), controlPoint1: CGPointMake(-4.26, 3.06), controlPoint2: CGPointMake(-4.2, 3))
        foodPath.addLineToPoint(CGPointMake(6.1, 3))
        foodPath.addCurveToPoint(CGPointMake(6.23, 3.13), controlPoint1: CGPointMake(6.17, 3), controlPoint2: CGPointMake(6.23, 3.06))
        foodPath.addLineToPoint(CGPointMake(6.23, 4))
        foodPath.closePath()
        foodPath.moveToPoint(CGPointMake(-7.19, -6.06))
        foodPath.addLineToPoint(CGPointMake(-0.82, -6.06))
        foodPath.addLineToPoint(CGPointMake(-1.07, -4))
        foodPath.addLineToPoint(CGPointMake(-1.26, -4))
        foodPath.addCurveToPoint(CGPointMake(-5.57, -0.78), controlPoint1: CGPointMake(-3.3, -4), controlPoint2: CGPointMake(-5.02, -2.64))
        foodPath.addCurveToPoint(CGPointMake(-4.61, 0.5), controlPoint1: CGPointMake(-5.76, -0.14), controlPoint2: CGPointMake(-5.27, 0.5))
        foodPath.addLineToPoint(CGPointMake(-4.75, 0.5))
        foodPath.addCurveToPoint(CGPointMake(-5.75, 1.5), controlPoint1: CGPointMake(-5.31, 0.5), controlPoint2: CGPointMake(-5.75, 0.95))
        foodPath.addCurveToPoint(CGPointMake(-5.03, 2.46), controlPoint1: CGPointMake(-5.75, 1.96), controlPoint2: CGPointMake(-5.45, 2.34))
        foodPath.addCurveToPoint(CGPointMake(-5.25, 3.13), controlPoint1: CGPointMake(-5.17, 2.65), controlPoint2: CGPointMake(-5.25, 2.87))
        foodPath.addLineToPoint(CGPointMake(-5.25, 4))
        foodPath.addCurveToPoint(CGPointMake(-5.14, 4.56), controlPoint1: CGPointMake(-5.25, 4.2), controlPoint2: CGPointMake(-5.21, 4.39))
        foodPath.addLineToPoint(CGPointMake(-5.92, 4.56))
        foodPath.addLineToPoint(CGPointMake(-7.19, -6.06))
        foodPath.closePath()
        foodPath.moveToPoint(CGPointMake(7.72, 1.5))
        foodPath.addCurveToPoint(CGPointMake(6.72, 0.5), controlPoint1: CGPointMake(7.72, 0.95), controlPoint2: CGPointMake(7.28, 0.5))
        foodPath.addLineToPoint(CGPointMake(6.58, 0.5))
        foodPath.addCurveToPoint(CGPointMake(7.54, -0.78), controlPoint1: CGPointMake(7.24, 0.5), controlPoint2: CGPointMake(7.73, -0.14))
        foodPath.addCurveToPoint(CGPointMake(3.23, -4), controlPoint1: CGPointMake(6.99, -2.64), controlPoint2: CGPointMake(5.27, -4))
        foodPath.addLineToPoint(CGPointMake(-0.12, -4))
        foodPath.addLineToPoint(CGPointMake(0.24, -7))
        foodPath.addLineToPoint(CGPointMake(-1.28, -7))
        foodPath.addLineToPoint(CGPointMake(-0.61, -9.25))
        foodPath.addLineToPoint(CGPointMake(1.53, -8.56))
        foodPath.addCurveToPoint(CGPointMake(1.69, -8.64), controlPoint1: CGPointMake(1.6, -8.54), controlPoint2: CGPointMake(1.67, -8.58))
        foodPath.addLineToPoint(CGPointMake(1.9, -9.3))
        foodPath.addCurveToPoint(CGPointMake(1.82, -9.45), controlPoint1: CGPointMake(1.92, -9.36), controlPoint2: CGPointMake(1.89, -9.43))
        foodPath.addLineToPoint(CGPointMake(-0.74, -10.28))
        foodPath.addCurveToPoint(CGPointMake(-1.37, -9.95), controlPoint1: CGPointMake(-1.01, -10.37), controlPoint2: CGPointMake(-1.29, -10.22))
        foodPath.addLineToPoint(CGPointMake(-2.26, -7))
        foodPath.addLineToPoint(CGPointMake(-8.25, -7))
        foodPath.addLineToPoint(CGPointMake(-6.75, 5.5))
        foodPath.addLineToPoint(CGPointMake(5.73, 5.5))
        foodPath.addCurveToPoint(CGPointMake(7.22, 4), controlPoint1: CGPointMake(6.55, 5.5), controlPoint2: CGPointMake(7.22, 4.83))
        foodPath.addLineToPoint(CGPointMake(7.22, 3.13))
        foodPath.addCurveToPoint(CGPointMake(7, 2.46), controlPoint1: CGPointMake(7.22, 2.87), controlPoint2: CGPointMake(7.14, 2.65))
        foodPath.addCurveToPoint(CGPointMake(7.72, 1.5), controlPoint1: CGPointMake(7.42, 2.34), controlPoint2: CGPointMake(7.72, 1.96))
        foodPath.addLineToPoint(CGPointMake(7.72, 1.5))
        foodPath.closePath()
        foodPath.usesEvenOddFillRule = true
        
        color.setFill()
        foodPath.fill()
    }
    
}
