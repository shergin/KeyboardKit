//
//  KeyboardObjectsEmojiCategoryView.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 5/31/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import UIKit


public final class KeyboardObjectsEmojiCategoryView: KeyboardEmojiCategoryView {

    public override var emojiCategory: KeyboardEmojiCategory {
        return .Objects
    }

    override func draw() {
        let color = self.tintColor

        let bulpPath = UIBezierPath()
        bulpPath.moveToPoint(CGPointMake(2.52, 1.28))
        bulpPath.addCurveToPoint(CGPointMake(1.65, 2.85), controlPoint1: CGPointMake(2, 1.63), controlPoint2: CGPointMake(1.67, 2.21))
        bulpPath.addLineToPoint(CGPointMake(1.59, 4))
        bulpPath.addLineToPoint(CGPointMake(-1.61, 4))
        bulpPath.addLineToPoint(CGPointMake(-1.66, 2.85))
        bulpPath.addCurveToPoint(CGPointMake(-2.57, 1.26), controlPoint1: CGPointMake(-1.69, 2.2), controlPoint2: CGPointMake(-2.04, 1.62))
        bulpPath.addCurveToPoint(CGPointMake(-4.56, -2.34), controlPoint1: CGPointMake(-3.73, 0.47), controlPoint2: CGPointMake(-4.51, -0.84))
        bulpPath.addCurveToPoint(CGPointMake(-0.15, -7.06), controlPoint1: CGPointMake(-4.65, -4.83), controlPoint2: CGPointMake(-2.63, -6.99))
        bulpPath.addCurveToPoint(CGPointMake(4.54, -2.5), controlPoint1: CGPointMake(2.43, -7.14), controlPoint2: CGPointMake(4.54, -5.06))
        bulpPath.addCurveToPoint(CGPointMake(2.52, 1.28), controlPoint1: CGPointMake(4.54, -0.92), controlPoint2: CGPointMake(3.74, 0.46))
        bulpPath.addLineToPoint(CGPointMake(2.52, 1.28))
        bulpPath.closePath()
        bulpPath.moveToPoint(CGPointMake(1.49, 6.46))
        bulpPath.addLineToPoint(CGPointMake(1.49, 6.48))
        bulpPath.addLineToPoint(CGPointMake(1.49, 6.5))
        bulpPath.addCurveToPoint(CGPointMake(0.99, 7), controlPoint1: CGPointMake(1.49, 6.78), controlPoint2: CGPointMake(1.32, 7))
        bulpPath.addLineToPoint(CGPointMake(-1.01, 7))
        bulpPath.addCurveToPoint(CGPointMake(-1.51, 6.5), controlPoint1: CGPointMake(-1.34, 7), controlPoint2: CGPointMake(-1.51, 6.78))
        bulpPath.addLineToPoint(CGPointMake(-0.01, 6.5))
        bulpPath.addLineToPoint(CGPointMake(-0.01, 5.5))
        bulpPath.addLineToPoint(CGPointMake(-1.55, 5.5))
        bulpPath.addLineToPoint(CGPointMake(-1.57, 5))
        bulpPath.addLineToPoint(CGPointMake(1.55, 5))
        bulpPath.addLineToPoint(CGPointMake(1.49, 6.46))
        bulpPath.closePath()
        bulpPath.moveToPoint(CGPointMake(-0.65, -7.96))
        bulpPath.addCurveToPoint(CGPointMake(-5.43, -3.42), controlPoint1: CGPointMake(-3.05, -7.69), controlPoint2: CGPointMake(-5.04, -5.81))
        bulpPath.addCurveToPoint(CGPointMake(-3.23, 1.95), controlPoint1: CGPointMake(-5.78, -1.22), controlPoint2: CGPointMake(-4.83, 0.79))
        bulpPath.addCurveToPoint(CGPointMake(-2.58, 3.12), controlPoint1: CGPointMake(-2.85, 2.23), controlPoint2: CGPointMake(-2.6, 2.65))
        bulpPath.addLineToPoint(CGPointMake(-2.44, 6.5))
        bulpPath.addCurveToPoint(CGPointMake(-1.01, 8), controlPoint1: CGPointMake(-2.44, 7.33), controlPoint2: CGPointMake(-1.83, 8))
        bulpPath.addLineToPoint(CGPointMake(0.99, 8))
        bulpPath.addCurveToPoint(CGPointMake(2.42, 6.5), controlPoint1: CGPointMake(1.81, 8), controlPoint2: CGPointMake(2.42, 7.33))
        bulpPath.addLineToPoint(CGPointMake(2.56, 3.12))
        bulpPath.addCurveToPoint(CGPointMake(3.2, 1.96), controlPoint1: CGPointMake(2.58, 2.66), controlPoint2: CGPointMake(2.83, 2.23))
        bulpPath.addCurveToPoint(CGPointMake(5.48, -2.5), controlPoint1: CGPointMake(4.58, 0.96), controlPoint2: CGPointMake(5.48, -0.67))
        bulpPath.addCurveToPoint(CGPointMake(-0.65, -7.96), controlPoint1: CGPointMake(5.48, -5.75), controlPoint2: CGPointMake(2.67, -8.34))
        bulpPath.addLineToPoint(CGPointMake(-0.65, -7.96))
        bulpPath.closePath()
        bulpPath.moveToPoint(CGPointMake(1.02, -1.25))
        bulpPath.addCurveToPoint(CGPointMake(0.4, -0.63), controlPoint1: CGPointMake(0.68, -1.25), controlPoint2: CGPointMake(0.4, -0.97))
        bulpPath.addCurveToPoint(CGPointMake(0.45, -0.39), controlPoint1: CGPointMake(0.4, -0.54), controlPoint2: CGPointMake(0.41, -0.46))
        bulpPath.addLineToPoint(CGPointMake(-0.26, 0.31))
        bulpPath.addLineToPoint(CGPointMake(-0.92, -0.35))
        bulpPath.addCurveToPoint(CGPointMake(-0.85, -0.63), controlPoint1: CGPointMake(-0.88, -0.44), controlPoint2: CGPointMake(-0.85, -0.53))
        bulpPath.addCurveToPoint(CGPointMake(-1.47, -1.25), controlPoint1: CGPointMake(-0.85, -0.97), controlPoint2: CGPointMake(-1.13, -1.25))
        bulpPath.addCurveToPoint(CGPointMake(-2.1, -0.63), controlPoint1: CGPointMake(-1.82, -1.25), controlPoint2: CGPointMake(-2.1, -0.97))
        bulpPath.addCurveToPoint(CGPointMake(-1.47, -0), controlPoint1: CGPointMake(-2.1, -0.28), controlPoint2: CGPointMake(-1.82, -0))
        bulpPath.addCurveToPoint(CGPointMake(-1.26, -0.04), controlPoint1: CGPointMake(-1.4, -0), controlPoint2: CGPointMake(-1.33, -0.02))
        bulpPath.addLineToPoint(CGPointMake(-0.48, 0.74))
        bulpPath.addLineToPoint(CGPointMake(-0.48, 3.12))
        bulpPath.addLineToPoint(CGPointMake(0.02, 3.12))
        bulpPath.addLineToPoint(CGPointMake(0.02, 0.74))
        bulpPath.addLineToPoint(CGPointMake(0.81, -0.04))
        bulpPath.addCurveToPoint(CGPointMake(1.02, -0), controlPoint1: CGPointMake(0.87, -0.02), controlPoint2: CGPointMake(0.95, -0))
        bulpPath.addCurveToPoint(CGPointMake(1.65, -0.63), controlPoint1: CGPointMake(1.37, -0), controlPoint2: CGPointMake(1.65, -0.28))
        bulpPath.addCurveToPoint(CGPointMake(1.02, -1.25), controlPoint1: CGPointMake(1.65, -0.97), controlPoint2: CGPointMake(1.37, -1.25))
        bulpPath.closePath()
        color.setFill()
        bulpPath.fill()
    }
    
}
