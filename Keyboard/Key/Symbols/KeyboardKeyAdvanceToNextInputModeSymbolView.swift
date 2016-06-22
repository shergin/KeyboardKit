//
//  KeyboardKeyAdvanceToNextInputModeSymbolView.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 1/12/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation


public final class KeyboardKeyAdvanceToNextInputModeSymbolView: KeyboardKeyDrawableSymbolView {
    override func draw() {
        let color = self.tintColor

        let globeVerticalLinePath = UIBezierPath()
        globeVerticalLinePath.moveToPoint(CGPoint(x: 0, y: -9.5))
        globeVerticalLinePath.addLineToPoint(CGPoint(x: 0, y: 9.5))
        color.setStroke()
        globeVerticalLinePath.lineWidth = 1
        globeVerticalLinePath.stroke()

        let globeHorizontalLinePath = UIBezierPath()
        globeHorizontalLinePath.moveToPoint(CGPoint(x: -9.5, y: 0))
        globeHorizontalLinePath.addLineToPoint(CGPoint(x: 9.5, y: 0))
        color.setStroke()
        globeHorizontalLinePath.lineWidth = 1
        globeHorizontalLinePath.stroke()

        let globeCirclePath = UIBezierPath(ovalInRect: CGRect(x: -9.5, y: -9.5, width: 19, height: 19))
        color.setStroke()
        globeCirclePath.lineWidth = 1
        globeCirclePath.stroke()

        let globeArcsPath = UIBezierPath()
        globeArcsPath.moveToPoint(CGPoint(x: 0.34, y: -9.49))
        globeArcsPath.addCurveToPoint(CGPoint(x: 5, y: 0), controlPoint1: CGPoint(x: 3.18, y: -7.3), controlPoint2: CGPoint(x: 5, y: -3.86))
        globeArcsPath.addCurveToPoint(CGPoint(x: 0.34, y: 9.49), controlPoint1: CGPoint(x: 5, y: 3.86), controlPoint2: CGPoint(x: 3.18, y: 7.3))
        globeArcsPath.addCurveToPoint(CGPoint(x: -0, y: 9.5), controlPoint1: CGPoint(x: 0.23, y: 9.5), controlPoint2: CGPoint(x: 0.11, y: 9.5))
        globeArcsPath.addCurveToPoint(CGPoint(x: -0.34, y: 9.49), controlPoint1: CGPoint(x: -0.11, y: 9.5), controlPoint2: CGPoint(x: -0.23, y: 9.5))
        globeArcsPath.addCurveToPoint(CGPoint(x: -5, y: 0), controlPoint1: CGPoint(x: -3.18, y: 7.3), controlPoint2: CGPoint(x: -5, y: 3.86))
        globeArcsPath.addCurveToPoint(CGPoint(x: -0.34, y: -9.49), controlPoint1: CGPoint(x: -5, y: -3.86), controlPoint2: CGPoint(x: -3.18, y: -7.3))
        globeArcsPath.addCurveToPoint(CGPoint(x: -0, y: -9.5), controlPoint1: CGPoint(x: -0.23, y: -9.5), controlPoint2: CGPoint(x: -0.11, y: -9.5))
        globeArcsPath.addCurveToPoint(CGPoint(x: 0.34, y: -9.49), controlPoint1: CGPoint(x: 0.11, y: -9.5), controlPoint2: CGPoint(x: 0.23, y: -9.5))
        globeArcsPath.closePath()
        globeArcsPath.moveToPoint(CGPoint(x: 7.09, y: 6.32))
        globeArcsPath.addCurveToPoint(CGPoint(x: -0, y: 4), controlPoint1: CGPoint(x: 5.11, y: 4.86), controlPoint2: CGPoint(x: 2.65, y: 4))
        globeArcsPath.addCurveToPoint(CGPoint(x: -7.09, y: 6.32), controlPoint1: CGPoint(x: -2.65, y: 4), controlPoint2: CGPoint(x: -5.11, y: 4.86))
        globeArcsPath.moveToPoint(CGPoint(x: -7.09, y: -6.32))
        globeArcsPath.addCurveToPoint(CGPoint(x: -0, y: -4), controlPoint1: CGPoint(x: -5.11, y: -4.86), controlPoint2: CGPoint(x: -2.65, y: -4))
        globeArcsPath.addCurveToPoint(CGPoint(x: 7.09, y: -6.32), controlPoint1: CGPoint(x: 2.65, y: -4), controlPoint2: CGPoint(x: 5.11, y: -4.86))
        color.setStroke()
        globeArcsPath.lineWidth = 1
        globeArcsPath.stroke()
    }
}
