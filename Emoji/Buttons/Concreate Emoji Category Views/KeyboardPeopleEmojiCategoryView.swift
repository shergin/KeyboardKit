//
//  KeyboardPeopleEmojiCategoryView.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 5/31/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import UIKit


public final class KeyboardPeopleEmojiCategoryView: KeyboardEmojiCategoryView {

    public override var emojiCategory: KeyboardEmojiCategory {
        return .People
    }

    internal override func draw() {
        super.draw()

        let color = self.tintColor

        let smileLeftEyePath = UIBezierPath(ovalInRect: CGRectMake(-3.25, -3, 1.5, 2))
        color.setFill()
        smileLeftEyePath.fill()

        let smileRightEyePath = UIBezierPath(ovalInRect: CGRectMake(1.5, -3, 1.5, 2))
        color.setFill()
        smileRightEyePath.fill()

        let smileMouthPath = UIBezierPath()
        smileMouthPath.moveToPoint(CGPointMake(4.38, 2.12))
        smileMouthPath.addCurveToPoint(CGPointMake(-0.01, 4.25), controlPoint1: CGPointMake(3.68, 3.22), controlPoint2: CGPointMake(1.98, 4.25))
        smileMouthPath.addCurveToPoint(CGPointMake(-4.41, 2.12), controlPoint1: CGPointMake(-2.01, 4.25), controlPoint2: CGPointMake(-3.71, 3.22))
        smileMouthPath.addCurveToPoint(CGPointMake(-4.1, 1.76), controlPoint1: CGPointMake(-4.54, 1.92), controlPoint2: CGPointMake(-4.32, 1.67))
        smileMouthPath.addCurveToPoint(CGPointMake(-0.01, 2.62), controlPoint1: CGPointMake(-3, 2.22), controlPoint2: CGPointMake(-1.58, 2.62))
        smileMouthPath.addCurveToPoint(CGPointMake(4.07, 1.76), controlPoint1: CGPointMake(1.55, 2.62), controlPoint2: CGPointMake(2.97, 2.22))
        smileMouthPath.addCurveToPoint(CGPointMake(4.38, 2.12), controlPoint1: CGPointMake(4.29, 1.67), controlPoint2: CGPointMake(4.51, 1.92))
        smileMouthPath.closePath()
        smileMouthPath.moveToPoint(CGPointMake(4.62, 0.85))
        smileMouthPath.addCurveToPoint(CGPointMake(-0.01, 1.75), controlPoint1: CGPointMake(3.34, 1.26), controlPoint2: CGPointMake(1.74, 1.75))
        smileMouthPath.addCurveToPoint(CGPointMake(-4.65, 0.85), controlPoint1: CGPointMake(-1.77, 1.75), controlPoint2: CGPointMake(-3.37, 1.26))
        smileMouthPath.addCurveToPoint(CGPointMake(-4.97, 1.11), controlPoint1: CGPointMake(-4.82, 0.8), controlPoint2: CGPointMake(-4.99, 0.93))
        smileMouthPath.addCurveToPoint(CGPointMake(-0.01, 6), controlPoint1: CGPointMake(-4.86, 2.31), controlPoint2: CGPointMake(-3.82, 6))
        smileMouthPath.addCurveToPoint(CGPointMake(4.94, 1.11), controlPoint1: CGPointMake(3.79, 6), controlPoint2: CGPointMake(4.83, 2.31))
        smileMouthPath.addCurveToPoint(CGPointMake(4.62, 0.85), controlPoint1: CGPointMake(4.96, 0.93), controlPoint2: CGPointMake(4.79, 0.8))
        smileMouthPath.closePath()
        smileMouthPath.usesEvenOddFillRule = true;
        color.setFill()
        smileMouthPath.fill()
        
        let smileHeadPath = UIBezierPath(ovalInRect: CGRectMake(-7.5, -7.5, 15, 15))
        color.setStroke()
        smileHeadPath.lineWidth = 1
        smileHeadPath.stroke()
    }

}
