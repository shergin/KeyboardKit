//
//  KeyboardConnectorShape.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 1/19/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import UIKit


internal final class KeyboardConnectorShape: KeyboardShape {

    var beginShape: KeyboardRectangleShape
    var endShape: KeyboardRectangleShape

    var beginDirection: KeyboardDirection
    var endDirection: KeyboardDirection

    internal override var hasUnderPath: Bool { return false }

    init(
        begin: (shape: KeyboardRectangleShape, direction: KeyboardDirection),
        end: (shape: KeyboardRectangleShape, direction: KeyboardDirection)
    ) {
        self.beginShape = begin.shape
        self.endShape = end.shape

        self.beginDirection = begin.direction
        self.endDirection = end.direction

        self.beginShape.attachmentDirection = beginDirection
        self.endShape.attachmentDirection = endDirection

        super.init()

        self.cornerRadius = beginShape.cornerRadius
    }

    deinit {
        self.beginShape.attachmentDirection = nil
        self.endShape.attachmentDirection = nil
    }

    override func createPaths() {
        let beginPoints = self.beginShape.attachmentPoints()
        let endPoints = self.endShape.attachmentPoints()

        let path = CGPathCreateMutable()

        CGPathMoveToPoint(path, nil, beginPoints.0.x, beginPoints.0.y)
        CGPathAddLineToPoint(path, nil, endPoints.1.x, endPoints.1.y)
        CGPathAddLineToPoint(path, nil, endPoints.0.x, endPoints.0.y)
        CGPathAddLineToPoint(path, nil, beginPoints.1.x, beginPoints.1.y)
        CGPathCloseSubpath(path)

        let isVertical =
            (self.beginDirection == KeyboardDirection.Up || self.beginDirection == KeyboardDirection.Down) &&
            (self.endDirection == KeyboardDirection.Up || self.endDirection == KeyboardDirection.Down)

        var midpoint: CGFloat

        if isVertical {
            midpoint = beginPoints.0.y + (endPoints.1.y - beginPoints.0.y) / 2
        }
        else {
            midpoint = beginPoints.0.x + (endPoints.1.x - beginPoints.0.x) / 2
        }

        let fillPath = UIBezierPath()
        var currentEdgePath = UIBezierPath()
        var edgePaths = [UIBezierPath]()


        let circleControlPointRatio = CGPoint(x: 0.552284749, y: 0.552284749)
        var fromPoint = CGPointZero
        var toPoint = CGPointZero
        var curveFromPoint = CGPointZero
        var curveToPoint = CGPointZero
        var curveControlPoint1 = CGPointZero
        var curveControlPoint2 = CGPointZero
        var deltaPoint = CGPointZero
        var absoluteDeltaPoint = CGPointZero

        // # 1
        fromPoint = beginPoints.0
        toPoint = endPoints.1
        deltaPoint = toPoint - fromPoint
        absoluteDeltaPoint = deltaPoint.absolute()

        currentEdgePath = UIBezierPath()

        if (absoluteDeltaPoint.x > absoluteDeltaPoint.y) != !isVertical  {
            let radius = min(absoluteDeltaPoint.x, absoluteDeltaPoint.y) / CGFloat(2.0)
            let radiusOffsetPoint = CGPoint(x: radius, y: radius) * deltaPoint.sign()

            fillPath.moveToPoint(fromPoint)
            currentEdgePath.moveToPoint(fromPoint)

            curveFromPoint = fromPoint
            curveToPoint = fromPoint + radiusOffsetPoint
            curveControlPoint1 = curveFromPoint + radiusOffsetPoint * CGPoint(x: 0, y: 1) * circleControlPointRatio
            curveControlPoint2 = curveToPoint + radiusOffsetPoint * CGPoint(x: -1, y: -0) * circleControlPointRatio

            fillPath.addCurveToPoint(curveToPoint, controlPoint1: curveControlPoint1, controlPoint2: curveControlPoint2)
            currentEdgePath.addCurveToPoint(curveToPoint, controlPoint1: curveControlPoint1, controlPoint2: curveControlPoint2)

            fillPath.addLineToPoint(toPoint - radiusOffsetPoint)
            currentEdgePath.addLineToPoint(toPoint - radiusOffsetPoint)

            curveFromPoint = toPoint - radiusOffsetPoint
            curveToPoint = toPoint
            curveControlPoint1 = curveFromPoint + radiusOffsetPoint * CGPoint(x: 1, y: 0) * circleControlPointRatio
            curveControlPoint2 = curveToPoint + radiusOffsetPoint * CGPoint(x: -0, y: -1) * circleControlPointRatio

            fillPath.addCurveToPoint(curveToPoint, controlPoint1: curveControlPoint1, controlPoint2: curveControlPoint2)
            currentEdgePath.addCurveToPoint(curveToPoint, controlPoint1: curveControlPoint1, controlPoint2: curveControlPoint2)
        }
        else {
            fillPath.moveToPoint(beginPoints.0)

            fillPath.addCurveToPoint(
                endPoints.1,
                controlPoint1: (isVertical ?
                    CGPointMake(beginPoints.0.x, midpoint) :
                    CGPointMake(midpoint, beginPoints.0.y)),
                controlPoint2: (isVertical ?
                    CGPointMake(endPoints.1.x, midpoint) :
                    CGPointMake(midpoint, endPoints.1.y)))

            currentEdgePath.moveToPoint(beginPoints.0)
            currentEdgePath.addCurveToPoint(
                endPoints.1,
                controlPoint1: (isVertical ?
                    CGPointMake(beginPoints.0.x, midpoint) :
                    CGPointMake(midpoint, beginPoints.0.y)),
                controlPoint2: (isVertical ?
                    CGPointMake(endPoints.1.x, midpoint) :
                    CGPointMake(midpoint, endPoints.1.y)))
        }

        currentEdgePath.applyTransform(CGAffineTransformMakeTranslation(-self.underOffset.x, -self.underOffset.y))
        edgePaths.append(currentEdgePath)

        // # end of 1

        // # 2
        fromPoint = endPoints.0
        toPoint = beginPoints.1
        deltaPoint = toPoint - fromPoint
        absoluteDeltaPoint = deltaPoint.absolute()

        fillPath.addLineToPoint(endPoints.0)

        if (absoluteDeltaPoint.x > absoluteDeltaPoint.y) != !isVertical  {
            let radius = min(absoluteDeltaPoint.x, absoluteDeltaPoint.y) / CGFloat(2.0)
            let radiusOffsetPoint = CGPoint(x: radius, y: radius) * deltaPoint.sign()

            fillPath.moveToPoint(fromPoint)
            currentEdgePath.moveToPoint(fromPoint)

            curveFromPoint = fromPoint
            curveToPoint = fromPoint + radiusOffsetPoint
            curveControlPoint1 = curveFromPoint + radiusOffsetPoint * CGPoint(x: 0, y: 1) * circleControlPointRatio
            curveControlPoint2 = curveToPoint + radiusOffsetPoint * CGPoint(x: -1, y: -0) * circleControlPointRatio

            fillPath.addCurveToPoint(curveToPoint, controlPoint1: curveControlPoint1, controlPoint2: curveControlPoint2)
            currentEdgePath.addCurveToPoint(curveToPoint, controlPoint1: curveControlPoint1, controlPoint2: curveControlPoint2)

            fillPath.addLineToPoint(toPoint - radiusOffsetPoint)
            currentEdgePath.addLineToPoint(toPoint - radiusOffsetPoint)

            curveFromPoint = toPoint - radiusOffsetPoint
            curveToPoint = toPoint
            curveControlPoint1 = curveFromPoint + radiusOffsetPoint * CGPoint(x: 1, y: 0) * circleControlPointRatio
            curveControlPoint2 = curveToPoint + radiusOffsetPoint * CGPoint(x: -0, y: -1) * circleControlPointRatio

            fillPath.addCurveToPoint(curveToPoint, controlPoint1: curveControlPoint1, controlPoint2: curveControlPoint2)
            currentEdgePath.addCurveToPoint(curveToPoint, controlPoint1: curveControlPoint1, controlPoint2: curveControlPoint2)
        }
        else {
            fillPath.addCurveToPoint(
                beginPoints.1,
                controlPoint1: (isVertical ?
                    CGPointMake(endPoints.0.x, midpoint) :
                    CGPointMake(midpoint, endPoints.0.y)),
                controlPoint2: (isVertical ?
                    CGPointMake(beginPoints.1.x, midpoint) :
                    CGPointMake(midpoint, beginPoints.1.y)))
            fillPath.addLineToPoint(beginPoints.0)

            currentEdgePath = UIBezierPath()
            currentEdgePath.moveToPoint(endPoints.0)
            currentEdgePath.addCurveToPoint(
                beginPoints.1,
                controlPoint1: (isVertical ?
                    CGPointMake(endPoints.0.x, midpoint) :
                    CGPointMake(midpoint, endPoints.0.y)),
                controlPoint2: (isVertical ?
                    CGPointMake(beginPoints.1.x, midpoint) :
                    CGPointMake(midpoint, beginPoints.1.y)))
        }

        currentEdgePath.applyTransform(CGAffineTransformMakeTranslation(-self.underOffset.x, -self.underOffset.y))
        edgePaths.append(currentEdgePath)

        // # end of 2

        fillPath.addLineToPoint(beginPoints.0)

        fillPath.closePath()
        fillPath.applyTransform(CGAffineTransformMakeTranslation(-self.underOffset.x, -self.underOffset.y))


        let compoundEdgePath = UIBezierPath()
        for edgePath in edgePaths {
            compoundEdgePath.appendPath(edgePath)
        }

        self.fillPath = fillPath
        self.edgePaths = edgePaths
        self.edgePath = compoundEdgePath
    }
}
