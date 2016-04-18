//
//  KeyboardKeyBackspaceSymbolView.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 1/12/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import UIKit


public final class KeyboardKeyBackspaceSymbolView: KeyboardKeySymbolView {
    override func drawCall(color: UIColor) {

        let ctx = UIGraphicsGetCurrentContext()
        CGContextSaveGState(ctx)
        CGContextTranslateCTM(ctx, self.bounds.size.width / 2.0, self.bounds.size.height / 2.0)


        let backspaceNormalPath = UIBezierPath()
        backspaceNormalPath.moveToPoint(CGPointMake(-1.5, -4))
        backspaceNormalPath.addLineToPoint(CGPointMake(-2.5, -3))
        backspaceNormalPath.addLineToPoint(CGPointMake(0.5, 0))
        backspaceNormalPath.addLineToPoint(CGPointMake(-2.5, 3))
        backspaceNormalPath.addLineToPoint(CGPointMake(-1.5, 4))
        backspaceNormalPath.addLineToPoint(CGPointMake(1.5, 1))
        backspaceNormalPath.addLineToPoint(CGPointMake(4.5, 4))
        backspaceNormalPath.addLineToPoint(CGPointMake(5.5, 3))
        backspaceNormalPath.addLineToPoint(CGPointMake(2.5, 0))
        backspaceNormalPath.addLineToPoint(CGPointMake(5.5, -3))
        backspaceNormalPath.addLineToPoint(CGPointMake(4.5, -4))
        backspaceNormalPath.addLineToPoint(CGPointMake(1.5, -1))
        backspaceNormalPath.addLineToPoint(CGPointMake(-1.5, -4))
        backspaceNormalPath.closePath()
        backspaceNormalPath.moveToPoint(CGPointMake(5.94, -7))
        backspaceNormalPath.addLineToPoint(CGPointMake(-2.5, -7))
        backspaceNormalPath.addLineToPoint(CGPointMake(-4, -6.5))
        backspaceNormalPath.addLineToPoint(CGPointMake(-10.5, 0))
        backspaceNormalPath.addLineToPoint(CGPointMake(-4, 6.5))
        backspaceNormalPath.addLineToPoint(CGPointMake(-2.5, 7))
        backspaceNormalPath.addLineToPoint(CGPointMake(5.94, 7))
        backspaceNormalPath.addCurveToPoint(CGPointMake(7.74, 6.85), controlPoint1: CGPointMake(6.82, 7), controlPoint2: CGPointMake(7.26, 7))
        backspaceNormalPath.addCurveToPoint(CGPointMake(8.85, 5.74), controlPoint1: CGPointMake(8.25, 6.66), controlPoint2: CGPointMake(8.66, 6.25))
        backspaceNormalPath.addCurveToPoint(CGPointMake(9, 3.94), controlPoint1: CGPointMake(9, 5.26), controlPoint2: CGPointMake(9, 4.82))
        backspaceNormalPath.addLineToPoint(CGPointMake(9, -3.94))
        backspaceNormalPath.addCurveToPoint(CGPointMake(8.85, -5.74), controlPoint1: CGPointMake(9, -4.82), controlPoint2: CGPointMake(9, -5.26))
        backspaceNormalPath.addCurveToPoint(CGPointMake(7.74, -6.85), controlPoint1: CGPointMake(8.66, -6.25), controlPoint2: CGPointMake(8.25, -6.66))
        backspaceNormalPath.addCurveToPoint(CGPointMake(5.94, -7), controlPoint1: CGPointMake(7.26, -7), controlPoint2: CGPointMake(6.82, -7))
        backspaceNormalPath.closePath()
        backspaceNormalPath.moveToPoint(CGPointMake(-3.5, -8.5))
        backspaceNormalPath.addCurveToPoint(CGPointMake(5.87, -8.5), controlPoint1: CGPointMake(-3.5, -8.5), controlPoint2: CGPointMake(5.87, -8.5))
        backspaceNormalPath.addCurveToPoint(CGPointMake(8.49, -8.3), controlPoint1: CGPointMake(7.23, -8.5), controlPoint2: CGPointMake(7.89, -8.5))
        backspaceNormalPath.addLineToPoint(CGPointMake(8.61, -8.28))
        backspaceNormalPath.addCurveToPoint(CGPointMake(10.28, -6.61), controlPoint1: CGPointMake(9.38, -7.99), controlPoint2: CGPointMake(9.99, -7.38))
        backspaceNormalPath.addCurveToPoint(CGPointMake(10.5, -3.91), controlPoint1: CGPointMake(10.5, -5.89), controlPoint2: CGPointMake(10.5, -5.23))
        backspaceNormalPath.addLineToPoint(CGPointMake(10.5, 3.91))
        backspaceNormalPath.addCurveToPoint(CGPointMake(10.3, 6.49), controlPoint1: CGPointMake(10.5, 5.23), controlPoint2: CGPointMake(10.5, 5.89))
        backspaceNormalPath.addLineToPoint(CGPointMake(10.28, 6.61))
        backspaceNormalPath.addCurveToPoint(CGPointMake(8.61, 8.28), controlPoint1: CGPointMake(9.99, 7.38), controlPoint2: CGPointMake(9.38, 7.99))
        backspaceNormalPath.addCurveToPoint(CGPointMake(5.91, 8.5), controlPoint1: CGPointMake(7.89, 8.5), controlPoint2: CGPointMake(7.23, 8.5))
        backspaceNormalPath.addLineToPoint(CGPointMake(-3.5, 8.5))
        backspaceNormalPath.addLineToPoint(CGPointMake(-5, 8))
        backspaceNormalPath.addLineToPoint(CGPointMake(-12.5, 0.5))
        backspaceNormalPath.addLineToPoint(CGPointMake(-12.5, -0.5))
        backspaceNormalPath.addLineToPoint(CGPointMake(-5, -8))
        backspaceNormalPath.addLineToPoint(CGPointMake(-3.5, -8.5))
        backspaceNormalPath.closePath()
        color.setFill()
        backspaceNormalPath.fill()

        //drawBackspace(self.bounds, color: color)
        CGContextRestoreGState(UIGraphicsGetCurrentContext())
    }
}


func drawBackspace(bounds: CGRect, color: UIColor) {
    let factors = getFactors(CGSizeMake(44, 32), toRect: bounds)
    let xScalingFactor = factors.xScalingFactor
    let yScalingFactor = factors.yScalingFactor
    let lineWidthScalingFactor = factors.lineWidthScalingFactor

    centerShape(CGSizeMake(44 * xScalingFactor, 32 * yScalingFactor), toRect: bounds)


    //// Color Declarations
    let color = color
    let color2 = UIColor.grayColor() // TODO:

    //// Bezier Drawing
    let bezierPath = UIBezierPath()
    bezierPath.moveToPoint(CGPointMake(16 * xScalingFactor, 32 * yScalingFactor))
    bezierPath.addLineToPoint(CGPointMake(38 * xScalingFactor, 32 * yScalingFactor))
    bezierPath.addCurveToPoint(CGPointMake(44 * xScalingFactor, 26 * yScalingFactor), controlPoint1: CGPointMake(38 * xScalingFactor, 32 * yScalingFactor), controlPoint2: CGPointMake(44 * xScalingFactor, 32 * yScalingFactor))
    bezierPath.addCurveToPoint(CGPointMake(44 * xScalingFactor, 6 * yScalingFactor), controlPoint1: CGPointMake(44 * xScalingFactor, 22 * yScalingFactor), controlPoint2: CGPointMake(44 * xScalingFactor, 6 * yScalingFactor))
    bezierPath.addCurveToPoint(CGPointMake(36 * xScalingFactor, 0 * yScalingFactor), controlPoint1: CGPointMake(44 * xScalingFactor, 6 * yScalingFactor), controlPoint2: CGPointMake(44 * xScalingFactor, 0 * yScalingFactor))
    bezierPath.addCurveToPoint(CGPointMake(16 * xScalingFactor, 0 * yScalingFactor), controlPoint1: CGPointMake(32 * xScalingFactor, 0 * yScalingFactor), controlPoint2: CGPointMake(16 * xScalingFactor, 0 * yScalingFactor))
    bezierPath.addLineToPoint(CGPointMake(0 * xScalingFactor, 18 * yScalingFactor))
    bezierPath.addLineToPoint(CGPointMake(16 * xScalingFactor, 32 * yScalingFactor))
    bezierPath.closePath()
    color.setFill()
    bezierPath.fill()


    //// Bezier 2 Drawing
    let bezier2Path = UIBezierPath()
    bezier2Path.moveToPoint(CGPointMake(20 * xScalingFactor, 10 * yScalingFactor))
    bezier2Path.addLineToPoint(CGPointMake(34 * xScalingFactor, 22 * yScalingFactor))
    bezier2Path.addLineToPoint(CGPointMake(20 * xScalingFactor, 10 * yScalingFactor))
    bezier2Path.closePath()
    UIColor.grayColor().setFill()
    bezier2Path.fill()
    color2.setStroke()
    bezier2Path.lineWidth = 2.5 * lineWidthScalingFactor
    bezier2Path.stroke()


    //// Bezier 3 Drawing
    let bezier3Path = UIBezierPath()
    bezier3Path.moveToPoint(CGPointMake(20 * xScalingFactor, 22 * yScalingFactor))
    bezier3Path.addLineToPoint(CGPointMake(34 * xScalingFactor, 10 * yScalingFactor))
    bezier3Path.addLineToPoint(CGPointMake(20 * xScalingFactor, 22 * yScalingFactor))
    bezier3Path.closePath()
    UIColor.redColor().setFill()
    bezier3Path.fill()
    color2.setStroke()
    bezier3Path.lineWidth = 2.5 * lineWidthScalingFactor
    bezier3Path.stroke()

    endCenter()
}

