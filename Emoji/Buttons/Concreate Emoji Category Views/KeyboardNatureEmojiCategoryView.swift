//
//  KeyboardNatureEmojiCategoryView.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 5/31/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import UIKit


public final class KeyboardNatureEmojiCategoryView: KeyboardEmojiCategoryView {

    public override var emojiCategory: KeyboardEmojiCategory {
        return .Nature
    }

    override func draw() {
        let color = self.tintColor

        let animalLeftEyePath = UIBezierPath(ovalInRect: CGRectMake(-3.95, -0.45, 1.4, 1.9))
        color.setFill()
        animalLeftEyePath.fill()

        let animalRightEyePath = UIBezierPath(ovalInRect: CGRectMake(2.55, -0.45, 1.4, 1.9))
        color.setFill()
        animalRightEyePath.fill()

        let animalBody = UIBezierPath()
        animalBody.moveToPoint(CGPointMake(3.43, 5.5))
        animalBody.addLineToPoint(CGPointMake(2.91, 5.5))
        animalBody.addCurveToPoint(CGPointMake(-0.01, 7.25), controlPoint1: CGPointMake(2.91, 5.5), controlPoint2: CGPointMake(2.5, 7.25))
        animalBody.addCurveToPoint(CGPointMake(-2.9, 5.5), controlPoint1: CGPointMake(-2.53, 7.25), controlPoint2: CGPointMake(-2.9, 5.5))
        animalBody.addLineToPoint(CGPointMake(-3.46, 5.5))
        animalBody.addCurveToPoint(CGPointMake(-7.25, 2.5), controlPoint1: CGPointMake(-3.72, 5.49), controlPoint2: CGPointMake(-7.25, 5.4))
        animalBody.addCurveToPoint(CGPointMake(-5.65, -0.09), controlPoint1: CGPointMake(-7.25, 1.44), controlPoint2: CGPointMake(-6.64, 0.45))
        animalBody.addCurveToPoint(CGPointMake(-5.32, -0.3), controlPoint1: CGPointMake(-5.65, -0.09), controlPoint2: CGPointMake(-5.33, -0.28))
        animalBody.addCurveToPoint(CGPointMake(0.23, -5.75), controlPoint1: CGPointMake(-5.46, -2.59), controlPoint2: CGPointMake(-2.57, -5.75))
        animalBody.addCurveToPoint(CGPointMake(5.19, -0.33), controlPoint1: CGPointMake(3.08, -5.75), controlPoint2: CGPointMake(5.49, -2.36))
        animalBody.addCurveToPoint(CGPointMake(5.6, -0.1), controlPoint1: CGPointMake(5.2, -0.32), controlPoint2: CGPointMake(5.6, -0.1))
        animalBody.addCurveToPoint(CGPointMake(7.22, 2.5), controlPoint1: CGPointMake(6.6, 0.44), controlPoint2: CGPointMake(7.22, 1.43))
        animalBody.addCurveToPoint(CGPointMake(3.43, 5.5), controlPoint1: CGPointMake(7.22, 5.33), controlPoint2: CGPointMake(3.73, 5.48))
        animalBody.closePath()
        animalBody.moveToPoint(CGPointMake(-6.78, -4.5))
        animalBody.addCurveToPoint(CGPointMake(-4.26, -7.28), controlPoint1: CGPointMake(-6.78, -6.03), controlPoint2: CGPointMake(-5.65, -7.28))
        animalBody.addCurveToPoint(CGPointMake(-2.1, -5.92), controlPoint1: CGPointMake(-3.34, -7.28), controlPoint2: CGPointMake(-2.54, -6.73))
        animalBody.addLineToPoint(CGPointMake(-2.1, -5.92))
        animalBody.addCurveToPoint(CGPointMake(-5.68, -2.2), controlPoint1: CGPointMake(-3.72, -5.13), controlPoint2: CGPointMake(-5.08, -3.64))
        animalBody.addLineToPoint(CGPointMake(-5.68, -2.21))
        animalBody.addCurveToPoint(CGPointMake(-6.78, -4.5), controlPoint1: CGPointMake(-6.34, -2.71), controlPoint2: CGPointMake(-6.78, -3.55))
        animalBody.closePath()
        animalBody.moveToPoint(CGPointMake(4.48, -7.28))
        animalBody.addCurveToPoint(CGPointMake(7, -4.5), controlPoint1: CGPointMake(5.87, -7.28), controlPoint2: CGPointMake(7, -6.03))
        animalBody.addCurveToPoint(CGPointMake(5.79, -2.13), controlPoint1: CGPointMake(7, -3.5), controlPoint2: CGPointMake(6.51, -2.62))
        animalBody.addLineToPoint(CGPointMake(5.79, -2.13))
        animalBody.addCurveToPoint(CGPointMake(2.37, -6.02), controlPoint1: CGPointMake(5.34, -3.65), controlPoint2: CGPointMake(4.05, -5.24))
        animalBody.addCurveToPoint(CGPointMake(4.48, -7.28), controlPoint1: CGPointMake(2.82, -6.77), controlPoint2: CGPointMake(3.59, -7.28))
        animalBody.closePath()
        animalBody.moveToPoint(CGPointMake(5.95, -0.76))
        animalBody.addCurveToPoint(CGPointMake(5.97, -1), controlPoint1: CGPointMake(5.96, -0.84), controlPoint2: CGPointMake(5.97, -0.92))
        animalBody.addCurveToPoint(CGPointMake(5.95, -1.38), controlPoint1: CGPointMake(5.97, -1.13), controlPoint2: CGPointMake(5.96, -1.25))
        animalBody.addCurveToPoint(CGPointMake(7.72, -4.5), controlPoint1: CGPointMake(7, -1.96), controlPoint2: CGPointMake(7.72, -3.14))
        animalBody.addCurveToPoint(CGPointMake(4.48, -8), controlPoint1: CGPointMake(7.72, -6.43), controlPoint2: CGPointMake(6.27, -8))
        animalBody.addCurveToPoint(CGPointMake(1.68, -6.27), controlPoint1: CGPointMake(3.29, -8), controlPoint2: CGPointMake(2.25, -7.3))
        animalBody.addLineToPoint(CGPointMake(1.68, -6.27))
        animalBody.addCurveToPoint(CGPointMake(0.23, -6.5), controlPoint1: CGPointMake(1.22, -6.41), controlPoint2: CGPointMake(0.74, -6.5))
        animalBody.addCurveToPoint(CGPointMake(-1.42, -6.2), controlPoint1: CGPointMake(-0.33, -6.5), controlPoint2: CGPointMake(-0.89, -6.39))
        animalBody.addLineToPoint(CGPointMake(-1.42, -6.2))
        animalBody.addCurveToPoint(CGPointMake(-4.26, -8), controlPoint1: CGPointMake(-1.98, -7.27), controlPoint2: CGPointMake(-3.04, -8))
        animalBody.addCurveToPoint(CGPointMake(-7.5, -4.5), controlPoint1: CGPointMake(-6.05, -8), controlPoint2: CGPointMake(-7.5, -6.43))
        animalBody.addCurveToPoint(CGPointMake(-5.91, -1.49), controlPoint1: CGPointMake(-7.5, -3.22), controlPoint2: CGPointMake(-6.86, -2.1))
        animalBody.addLineToPoint(CGPointMake(-5.91, -1.49))
        animalBody.addCurveToPoint(CGPointMake(-6, -0.75), controlPoint1: CGPointMake(-5.97, -1.24), controlPoint2: CGPointMake(-6, -0.99))
        animalBody.addCurveToPoint(CGPointMake(-6, -0.74), controlPoint1: CGPointMake(-6, -0.75), controlPoint2: CGPointMake(-6, -0.75))
        animalBody.addCurveToPoint(CGPointMake(-8, 2.5), controlPoint1: CGPointMake(-7.2, -0.1), controlPoint2: CGPointMake(-8, 1.11))
        animalBody.addCurveToPoint(CGPointMake(-3.45, 6.38), controlPoint1: CGPointMake(-8, 5.95), controlPoint2: CGPointMake(-4.03, 6.38))
        animalBody.addCurveToPoint(CGPointMake(-3.38, 6.38), controlPoint1: CGPointMake(-3.42, 6.38), controlPoint2: CGPointMake(-3.4, 6.38))
        animalBody.addCurveToPoint(CGPointMake(-0.01, 8), controlPoint1: CGPointMake(-3.03, 7.31), controlPoint2: CGPointMake(-1.53, 8))
        animalBody.addCurveToPoint(CGPointMake(3.35, 6.38), controlPoint1: CGPointMake(1.5, 8), controlPoint2: CGPointMake(2.87, 7.43))
        animalBody.addCurveToPoint(CGPointMake(3.41, 6.38), controlPoint1: CGPointMake(3.36, 6.38), controlPoint2: CGPointMake(3.38, 6.38))
        animalBody.addCurveToPoint(CGPointMake(7.97, 2.5), controlPoint1: CGPointMake(3.96, 6.38), controlPoint2: CGPointMake(7.97, 5.91))
        animalBody.addCurveToPoint(CGPointMake(5.95, -0.76), controlPoint1: CGPointMake(7.97, 1.1), controlPoint2: CGPointMake(7.15, -0.11))
        animalBody.closePath()
        animalBody.moveToPoint(CGPointMake(1.64, 5))
        animalBody.addCurveToPoint(CGPointMake(0.67, 5.25), controlPoint1: CGPointMake(1.37, 5), controlPoint2: CGPointMake(0.93, 5.16))
        animalBody.addCurveToPoint(CGPointMake(0.48, 5.31), controlPoint1: CGPointMake(0.67, 5.25), controlPoint2: CGPointMake(0.6, 5.29))
        animalBody.addLineToPoint(CGPointMake(0.48, 3.98))
        animalBody.addCurveToPoint(CGPointMake(1.23, 3.5), controlPoint1: CGPointMake(0.79, 3.93), controlPoint2: CGPointMake(0.97, 3.76))
        animalBody.addLineToPoint(CGPointMake(1.23, 3.5))
        animalBody.addCurveToPoint(CGPointMake(0.57, 2.5), controlPoint1: CGPointMake(1.6, 3.13), controlPoint2: CGPointMake(1.09, 2.5))
        animalBody.addLineToPoint(CGPointMake(-0.6, 2.5))
        animalBody.addCurveToPoint(CGPointMake(-1.26, 3.5), controlPoint1: CGPointMake(-1.12, 2.5), controlPoint2: CGPointMake(-1.63, 3.13))
        animalBody.addLineToPoint(CGPointMake(-1.26, 3.5))
        animalBody.addCurveToPoint(CGPointMake(-0.51, 3.98), controlPoint1: CGPointMake(-1, 3.76), controlPoint2: CGPointMake(-0.82, 3.93))
        animalBody.addLineToPoint(CGPointMake(-0.51, 5.31))
        animalBody.addCurveToPoint(CGPointMake(-0.7, 5.25), controlPoint1: CGPointMake(-0.63, 5.29), controlPoint2: CGPointMake(-0.7, 5.25))
        animalBody.addCurveToPoint(CGPointMake(-1.67, 5), controlPoint1: CGPointMake(-0.96, 5.16), controlPoint2: CGPointMake(-1.4, 5))
        animalBody.addLineToPoint(CGPointMake(-1.88, 5))
        animalBody.addCurveToPoint(CGPointMake(-1.98, 5.3), controlPoint1: CGPointMake(-2.16, 5), controlPoint2: CGPointMake(-2.2, 5.13))
        animalBody.addCurveToPoint(CGPointMake(-0.02, 6), controlPoint1: CGPointMake(-1.98, 5.3), controlPoint2: CGPointMake(-1.03, 6))
        animalBody.addCurveToPoint(CGPointMake(1.95, 5.3), controlPoint1: CGPointMake(1, 6), controlPoint2: CGPointMake(1.95, 5.3))
        animalBody.addCurveToPoint(CGPointMake(1.85, 5), controlPoint1: CGPointMake(2.17, 5.13), controlPoint2: CGPointMake(2.13, 5))
        animalBody.addLineToPoint(CGPointMake(1.64, 5))
        animalBody.closePath()
        color.setFill()
        animalBody.fill()
    }
    
}
