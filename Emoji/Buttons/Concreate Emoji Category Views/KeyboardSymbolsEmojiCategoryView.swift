//
//  KeyboardSymbolsEmojiCategoryView.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 5/31/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import UIKit


public final class KeyboardSymbolsEmojiCategoryView: KeyboardEmojiCategoryView {

    public override var emojiCategory: KeyboardEmojiCategory {
        return .Symbols
    }

    internal override func draw() {
        super.draw()

        let color = self.tintColor

        let ampersandSymbolPath = UIBezierPath()
        ampersandSymbolPath.moveToPoint(CGPointMake(-4.17, 7.02))
        ampersandSymbolPath.addCurveToPoint(CGPointMake(-5.67, 5.74), controlPoint1: CGPointMake(-4.94, 7.02), controlPoint2: CGPointMake(-5.67, 6.61))
        ampersandSymbolPath.addCurveToPoint(CGPointMake(-4.69, 4.41), controlPoint1: CGPointMake(-5.67, 5.11), controlPoint2: CGPointMake(-5.28, 4.74))
        ampersandSymbolPath.addCurveToPoint(CGPointMake(-4.47, 4.3), controlPoint1: CGPointMake(-4.62, 4.37), controlPoint2: CGPointMake(-4.55, 4.34))
        ampersandSymbolPath.addLineToPoint(CGPointMake(-2.58, 6.39))
        ampersandSymbolPath.addCurveToPoint(CGPointMake(-4.17, 7.02), controlPoint1: CGPointMake(-3.01, 6.84), controlPoint2: CGPointMake(-3.66, 7.02))
        ampersandSymbolPath.closePath()
        ampersandSymbolPath.moveToPoint(CGPointMake(-4.97, 2.33))
        ampersandSymbolPath.addCurveToPoint(CGPointMake(-4.06, 1.44), controlPoint1: CGPointMake(-4.97, 1.82), controlPoint2: CGPointMake(-4.6, 1.44))
        ampersandSymbolPath.addCurveToPoint(CGPointMake(-3.15, 2.32), controlPoint1: CGPointMake(-3.53, 1.44), controlPoint2: CGPointMake(-3.15, 1.8))
        ampersandSymbolPath.addCurveToPoint(CGPointMake(-4.25, 3.54), controlPoint1: CGPointMake(-3.15, 2.91), controlPoint2: CGPointMake(-3.62, 3.22))
        ampersandSymbolPath.addCurveToPoint(CGPointMake(-4.97, 2.33), controlPoint1: CGPointMake(-4.79, 3), controlPoint2: CGPointMake(-4.97, 2.69))
        ampersandSymbolPath.closePath()
        ampersandSymbolPath.moveToPoint(CGPointMake(-1.12, 3.92))
        ampersandSymbolPath.addLineToPoint(CGPointMake(-1.12, 3.74))
        ampersandSymbolPath.addLineToPoint(CGPointMake(-1.85, 3.74))
        ampersandSymbolPath.addLineToPoint(CGPointMake(-1.85, 3.92))
        ampersandSymbolPath.addCurveToPoint(CGPointMake(-2.16, 5.81), controlPoint1: CGPointMake(-1.85, 4.76), controlPoint2: CGPointMake(-1.94, 5.38))
        ampersandSymbolPath.addLineToPoint(CGPointMake(-3.83, 3.99))
        ampersandSymbolPath.addCurveToPoint(CGPointMake(-2.4, 2.31), controlPoint1: CGPointMake(-3.04, 3.58), controlPoint2: CGPointMake(-2.4, 3.12))
        ampersandSymbolPath.addCurveToPoint(CGPointMake(-4.06, 0.82), controlPoint1: CGPointMake(-2.4, 1.44), controlPoint2: CGPointMake(-3.11, 0.82))
        ampersandSymbolPath.addCurveToPoint(CGPointMake(-5.72, 2.29), controlPoint1: CGPointMake(-5.05, 0.82), controlPoint2: CGPointMake(-5.72, 1.49))
        ampersandSymbolPath.addCurveToPoint(CGPointMake(-4.9, 3.82), controlPoint1: CGPointMake(-5.72, 2.91), controlPoint2: CGPointMake(-5.32, 3.38))
        ampersandSymbolPath.addCurveToPoint(CGPointMake(-5.14, 3.94), controlPoint1: CGPointMake(-4.98, 3.86), controlPoint2: CGPointMake(-5.06, 3.91))
        ampersandSymbolPath.addCurveToPoint(CGPointMake(-6.45, 5.79), controlPoint1: CGPointMake(-5.9, 4.36), controlPoint2: CGPointMake(-6.45, 4.91))
        ampersandSymbolPath.addCurveToPoint(CGPointMake(-4.23, 7.67), controlPoint1: CGPointMake(-6.45, 6.97), controlPoint2: CGPointMake(-5.45, 7.67))
        ampersandSymbolPath.addCurveToPoint(CGPointMake(-2.12, 6.88), controlPoint1: CGPointMake(-3.62, 7.67), controlPoint2: CGPointMake(-2.81, 7.49))
        ampersandSymbolPath.addLineToPoint(CGPointMake(-1.5, 7.55))
        ampersandSymbolPath.addLineToPoint(CGPointMake(-0.51, 7.55))
        ampersandSymbolPath.addLineToPoint(CGPointMake(-1.65, 6.33))
        ampersandSymbolPath.addCurveToPoint(CGPointMake(-1.12, 3.92), controlPoint1: CGPointMake(-1.28, 5.75), controlPoint2: CGPointMake(-1.12, 4.95))
        ampersandSymbolPath.closePath()
        ampersandSymbolPath.usesEvenOddFillRule = true;

        color.setFill()
        ampersandSymbolPath.fill()

        let musicSymbolPath = UIBezierPath()
        musicSymbolPath.moveToPoint(CGPointMake(3.54, -1.28))
        musicSymbolPath.addCurveToPoint(CGPointMake(4.55, -2.72), controlPoint1: CGPointMake(4.16, -1.68), controlPoint2: CGPointMake(4.54, -2.25))
        musicSymbolPath.addLineToPoint(CGPointMake(4.55, -2.72))
        musicSymbolPath.addLineToPoint(CGPointMake(4.55, -6.96))
        musicSymbolPath.addCurveToPoint(CGPointMake(5.73, -3.1), controlPoint1: CGPointMake(8.41, -6), controlPoint2: CGPointMake(5.73, -3.1))
        musicSymbolPath.addCurveToPoint(CGPointMake(4.49, -8.47), controlPoint1: CGPointMake(9.38, -6.38), controlPoint2: CGPointMake(4.49, -8.47))
        musicSymbolPath.addLineToPoint(CGPointMake(4.05, -8.47))
        musicSymbolPath.addLineToPoint(CGPointMake(4.05, -3.41))
        musicSymbolPath.addCurveToPoint(CGPointMake(2.4, -3.07), controlPoint1: CGPointMake(3.62, -3.56), controlPoint2: CGPointMake(2.99, -3.45))
        musicSymbolPath.addCurveToPoint(CGPointMake(1.5, -1.23), controlPoint1: CGPointMake(1.59, -2.55), controlPoint2: CGPointMake(1.18, -1.73))
        musicSymbolPath.addCurveToPoint(CGPointMake(3.54, -1.28), controlPoint1: CGPointMake(1.81, -0.74), controlPoint2: CGPointMake(2.73, -0.76))
        musicSymbolPath.closePath()
        musicSymbolPath.usesEvenOddFillRule = true;
        color.setFill()
        musicSymbolPath.fill()

        let percentSymbolPath = UIBezierPath()
        percentSymbolPath.moveToPoint(CGPointMake(6.75, 5.71))
        percentSymbolPath.addCurveToPoint(CGPointMake(5.99, 6.86), controlPoint1: CGPointMake(6.75, 6.38), controlPoint2: CGPointMake(6.47, 6.86))
        percentSymbolPath.addCurveToPoint(CGPointMake(5.23, 5.7), controlPoint1: CGPointMake(5.49, 6.86), controlPoint2: CGPointMake(5.23, 6.37))
        percentSymbolPath.addLineToPoint(CGPointMake(5.23, 5.66))
        percentSymbolPath.addCurveToPoint(CGPointMake(5.99, 4.53), controlPoint1: CGPointMake(5.23, 5.05), controlPoint2: CGPointMake(5.47, 4.53))
        percentSymbolPath.addCurveToPoint(CGPointMake(6.75, 5.68), controlPoint1: CGPointMake(6.49, 4.53), controlPoint2: CGPointMake(6.75, 5.02))
        percentSymbolPath.addLineToPoint(CGPointMake(6.75, 5.71))
        percentSymbolPath.closePath()
        percentSymbolPath.moveToPoint(CGPointMake(5.99, 3.99))
        percentSymbolPath.addCurveToPoint(CGPointMake(4.65, 5.62), controlPoint1: CGPointMake(5.13, 3.99), controlPoint2: CGPointMake(4.65, 4.74))
        percentSymbolPath.addLineToPoint(CGPointMake(4.65, 5.75))
        percentSymbolPath.addCurveToPoint(CGPointMake(5.98, 7.4), controlPoint1: CGPointMake(4.65, 6.66), controlPoint2: CGPointMake(5.12, 7.4))
        percentSymbolPath.addCurveToPoint(CGPointMake(7.33, 5.76), controlPoint1: CGPointMake(6.84, 7.4), controlPoint2: CGPointMake(7.33, 6.65))
        percentSymbolPath.addLineToPoint(CGPointMake(7.33, 5.63))
        percentSymbolPath.addCurveToPoint(CGPointMake(5.99, 3.99), controlPoint1: CGPointMake(7.33, 4.73), controlPoint2: CGPointMake(6.83, 3.99))
        percentSymbolPath.addLineToPoint(CGPointMake(5.99, 3.99))
        percentSymbolPath.closePath()
        percentSymbolPath.moveToPoint(CGPointMake(1.32, 2.31))
        percentSymbolPath.addCurveToPoint(CGPointMake(2.08, 1.18), controlPoint1: CGPointMake(1.32, 1.69), controlPoint2: CGPointMake(1.56, 1.18))
        percentSymbolPath.addCurveToPoint(CGPointMake(2.84, 2.32), controlPoint1: CGPointMake(2.58, 1.18), controlPoint2: CGPointMake(2.84, 1.66))
        percentSymbolPath.addLineToPoint(CGPointMake(2.84, 2.36))
        percentSymbolPath.addCurveToPoint(CGPointMake(2.08, 3.51), controlPoint1: CGPointMake(2.84, 3.03), controlPoint2: CGPointMake(2.56, 3.51))
        percentSymbolPath.addCurveToPoint(CGPointMake(1.32, 2.34), controlPoint1: CGPointMake(1.58, 3.51), controlPoint2: CGPointMake(1.32, 3.01))
        percentSymbolPath.addLineToPoint(CGPointMake(1.32, 2.31))
        percentSymbolPath.closePath()
        percentSymbolPath.moveToPoint(CGPointMake(2.07, 4.05))
        percentSymbolPath.addCurveToPoint(CGPointMake(3.42, 2.41), controlPoint1: CGPointMake(2.93, 4.05), controlPoint2: CGPointMake(3.42, 3.3))
        percentSymbolPath.addLineToPoint(CGPointMake(3.42, 2.28))
        percentSymbolPath.addCurveToPoint(CGPointMake(2.08, 0.64), controlPoint1: CGPointMake(3.42, 1.38), controlPoint2: CGPointMake(2.93, 0.64))
        percentSymbolPath.addCurveToPoint(CGPointMake(0.74, 2.26), controlPoint1: CGPointMake(1.22, 0.64), controlPoint2: CGPointMake(0.74, 1.39))
        percentSymbolPath.addLineToPoint(CGPointMake(0.74, 2.39))
        percentSymbolPath.addCurveToPoint(CGPointMake(2.07, 4.05), controlPoint1: CGPointMake(0.74, 3.3), controlPoint2: CGPointMake(1.21, 4.05))
        percentSymbolPath.addLineToPoint(CGPointMake(2.07, 4.05))
        percentSymbolPath.closePath()
        percentSymbolPath.moveToPoint(CGPointMake(6.2, 0.69))
        percentSymbolPath.addLineToPoint(CGPointMake(1.14, 7.36))
        percentSymbolPath.addLineToPoint(CGPointMake(1.84, 7.36))
        percentSymbolPath.addLineToPoint(CGPointMake(6.9, 0.69))
        percentSymbolPath.addLineToPoint(CGPointMake(6.2, 0.69))
        percentSymbolPath.closePath()
        color.setFill()
        percentSymbolPath.fill()

        let bordersSymbolPath = UIBezierPath()
        bordersSymbolPath.moveToPoint(CGPointMake(-7, -7))
        bordersSymbolPath.addLineToPoint(CGPointMake(0, -7))
        bordersSymbolPath.addLineToPoint(CGPointMake(0, -8))
        bordersSymbolPath.addLineToPoint(CGPointMake(-7, -8))
        bordersSymbolPath.addLineToPoint(CGPointMake(-7, -7))
        bordersSymbolPath.closePath()
        bordersSymbolPath.moveToPoint(CGPointMake(-7, -5))
        bordersSymbolPath.addLineToPoint(CGPointMake(-4, -5))
        bordersSymbolPath.addLineToPoint(CGPointMake(-4, -1))
        bordersSymbolPath.addLineToPoint(CGPointMake(-3, -1))
        bordersSymbolPath.addLineToPoint(CGPointMake(-3, -5))
        bordersSymbolPath.addLineToPoint(CGPointMake(0, -5))
        bordersSymbolPath.addLineToPoint(CGPointMake(0, -6))
        bordersSymbolPath.addLineToPoint(CGPointMake(-7, -6))
        bordersSymbolPath.addLineToPoint(CGPointMake(-7, -5))
        bordersSymbolPath.closePath()
        color.setFill()
        bordersSymbolPath.fill()

    }
    
}
