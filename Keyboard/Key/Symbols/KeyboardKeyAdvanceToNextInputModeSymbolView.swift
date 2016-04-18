//
//  KeyboardKeyAdvanceToNextInputModeSymbolView.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 1/12/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation


public final class KeyboardKeyAdvanceToNextInputModeSymbolView: KeyboardKeySymbolView {
    override func drawCall(color: UIColor) {
        drawGlobe(self.bounds, color: color)
    }
}

func drawGlobe(bounds: CGRect, color: UIColor) {
    let factors = getFactors(CGSizeMake(41, 40), toRect: bounds)
    let xScalingFactor = factors.xScalingFactor
    let yScalingFactor = factors.yScalingFactor
    let lineWidthScalingFactor = factors.lineWidthScalingFactor * 1.5

    centerShape(CGSizeMake(41 * xScalingFactor, 40 * yScalingFactor), toRect: bounds)


    //// Color Declarations
    let color = color

    //// Oval Drawing
    let ovalPath = UIBezierPath(ovalInRect: CGRectMake(0 * xScalingFactor, 0 * yScalingFactor, 40 * xScalingFactor, 40 * yScalingFactor))
    color.setStroke()
    ovalPath.lineWidth = 1 * lineWidthScalingFactor
    ovalPath.stroke()


    //// Bezier Drawing
    let bezierPath = UIBezierPath()
    bezierPath.moveToPoint(CGPointMake(20 * xScalingFactor, -0 * yScalingFactor))
    bezierPath.addLineToPoint(CGPointMake(20 * xScalingFactor, 40 * yScalingFactor))
    bezierPath.addLineToPoint(CGPointMake(20 * xScalingFactor, -0 * yScalingFactor))
    bezierPath.closePath()
    color.setStroke()
    bezierPath.lineWidth = 1 * lineWidthScalingFactor
    bezierPath.stroke()


    //// Bezier 2 Drawing
    let bezier2Path = UIBezierPath()
    bezier2Path.moveToPoint(CGPointMake(0.5 * xScalingFactor, 19.5 * yScalingFactor))
    bezier2Path.addLineToPoint(CGPointMake(39.5 * xScalingFactor, 19.5 * yScalingFactor))
    bezier2Path.addLineToPoint(CGPointMake(0.5 * xScalingFactor, 19.5 * yScalingFactor))
    bezier2Path.closePath()
    color.setStroke()
    bezier2Path.lineWidth = 1 * lineWidthScalingFactor
    bezier2Path.stroke()


    //// Bezier 3 Drawing
    let bezier3Path = UIBezierPath()
    bezier3Path.moveToPoint(CGPointMake(21.63 * xScalingFactor, 0.42 * yScalingFactor))
    bezier3Path.addCurveToPoint(CGPointMake(21.63 * xScalingFactor, 39.6 * yScalingFactor), controlPoint1: CGPointMake(21.63 * xScalingFactor, 0.42 * yScalingFactor), controlPoint2: CGPointMake(41 * xScalingFactor, 19 * yScalingFactor))
    bezier3Path.lineCapStyle = .Round;

    color.setStroke()
    bezier3Path.lineWidth = 1 * lineWidthScalingFactor
    bezier3Path.stroke()


    //// Bezier 4 Drawing
    let bezier4Path = UIBezierPath()
    bezier4Path.moveToPoint(CGPointMake(17.76 * xScalingFactor, 0.74 * yScalingFactor))
    bezier4Path.addCurveToPoint(CGPointMake(18.72 * xScalingFactor, 39.6 * yScalingFactor), controlPoint1: CGPointMake(17.76 * xScalingFactor, 0.74 * yScalingFactor), controlPoint2: CGPointMake(-2.5 * xScalingFactor, 19.04 * yScalingFactor))
    bezier4Path.lineCapStyle = .Round;

    color.setStroke()
    bezier4Path.lineWidth = 1 * lineWidthScalingFactor
    bezier4Path.stroke()


    //// Bezier 5 Drawing
    let bezier5Path = UIBezierPath()
    bezier5Path.moveToPoint(CGPointMake(6 * xScalingFactor, 7 * yScalingFactor))
    bezier5Path.addCurveToPoint(CGPointMake(34 * xScalingFactor, 7 * yScalingFactor), controlPoint1: CGPointMake(6 * xScalingFactor, 7 * yScalingFactor), controlPoint2: CGPointMake(19 * xScalingFactor, 21 * yScalingFactor))
    bezier5Path.lineCapStyle = .Round;

    color.setStroke()
    bezier5Path.lineWidth = 1 * lineWidthScalingFactor
    bezier5Path.stroke()


    //// Bezier 6 Drawing
    let bezier6Path = UIBezierPath()
    bezier6Path.moveToPoint(CGPointMake(6 * xScalingFactor, 33 * yScalingFactor))
    bezier6Path.addCurveToPoint(CGPointMake(34 * xScalingFactor, 33 * yScalingFactor), controlPoint1: CGPointMake(6 * xScalingFactor, 33 * yScalingFactor), controlPoint2: CGPointMake(19 * xScalingFactor, 22 * yScalingFactor))
    bezier6Path.lineCapStyle = .Round;

    color.setStroke()
    bezier6Path.lineWidth = 1 * lineWidthScalingFactor
    bezier6Path.stroke()

    endCenter()
}
