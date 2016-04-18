//
//  KeyboardKeyShiftSymbolView.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 1/12/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import UIKit

public final class KeyboardKeyShiftSymbolView: KeyboardKeySymbolView {
    public var withLock: Bool = false {
        didSet {
            self.overflowCanvas.setNeedsDisplay()
        }
    }

    override func drawCall(color: UIColor) {
        drawShift(self.bounds, color: color, withRect: self.withLock)
    }
}


func drawShift(bounds: CGRect, color: UIColor, withRect: Bool) {
    let factors = getFactors(CGSizeMake(38, (withRect ? 34 + 4 : 32)), toRect: bounds)
    let xScalingFactor = factors.xScalingFactor
    let yScalingFactor = factors.yScalingFactor
    //let lineWidthScalingFactor = factors.lineWidthScalingFactor

    centerShape(CGSizeMake(38 * xScalingFactor, (withRect ? 34 + 4 : 32) * yScalingFactor), toRect: bounds)


    //// Color Declarations
    let color2 = color

    //// Bezier Drawing
    let bezierPath = UIBezierPath()
    bezierPath.moveToPoint(CGPointMake(28 * xScalingFactor, 18 * yScalingFactor))
    bezierPath.addLineToPoint(CGPointMake(38 * xScalingFactor, 18 * yScalingFactor))
    bezierPath.addLineToPoint(CGPointMake(38 * xScalingFactor, 18 * yScalingFactor))
    bezierPath.addLineToPoint(CGPointMake(19 * xScalingFactor, 0 * yScalingFactor))
    bezierPath.addLineToPoint(CGPointMake(0 * xScalingFactor, 18 * yScalingFactor))
    bezierPath.addLineToPoint(CGPointMake(0 * xScalingFactor, 18 * yScalingFactor))
    bezierPath.addLineToPoint(CGPointMake(10 * xScalingFactor, 18 * yScalingFactor))
    bezierPath.addLineToPoint(CGPointMake(10 * xScalingFactor, 28 * yScalingFactor))
    bezierPath.addCurveToPoint(CGPointMake(14 * xScalingFactor, 32 * yScalingFactor), controlPoint1: CGPointMake(10 * xScalingFactor, 28 * yScalingFactor), controlPoint2: CGPointMake(10 * xScalingFactor, 32 * yScalingFactor))
    bezierPath.addCurveToPoint(CGPointMake(24 * xScalingFactor, 32 * yScalingFactor), controlPoint1: CGPointMake(16 * xScalingFactor, 32 * yScalingFactor), controlPoint2: CGPointMake(24 * xScalingFactor, 32 * yScalingFactor))
    bezierPath.addCurveToPoint(CGPointMake(28 * xScalingFactor, 28 * yScalingFactor), controlPoint1: CGPointMake(24 * xScalingFactor, 32 * yScalingFactor), controlPoint2: CGPointMake(28 * xScalingFactor, 32 * yScalingFactor))
    bezierPath.addCurveToPoint(CGPointMake(28 * xScalingFactor, 18 * yScalingFactor), controlPoint1: CGPointMake(28 * xScalingFactor, 26 * yScalingFactor), controlPoint2: CGPointMake(28 * xScalingFactor, 18 * yScalingFactor))
    bezierPath.closePath()
    color2.setFill()
    bezierPath.fill()


    if withRect {
        //// Rectangle Drawing
        let rectanglePath = UIBezierPath(rect: CGRectMake(10 * xScalingFactor, 34 * yScalingFactor, 18 * xScalingFactor, 4 * yScalingFactor))
        color2.setFill()
        rectanglePath.fill()
    }

    endCenter()
}

