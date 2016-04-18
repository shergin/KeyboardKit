//
//  KeyboardKeyShapeView.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 1/12/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import UIKit

/*
PERFORMANCE NOTES

* CAShapeLayer: convenient and low memory usage, but chunky rotations
* drawRect: fast, but high memory usage (looks like there's a backing store for each of the 3 views)
* if I set CAShapeLayer to shouldRasterize, perf is *almost* the same as drawRect, while mem usage is the same as before
* oddly, 3 CAShapeLayers show the same memory usage as 1 CAShapeLayer — where is the backing store?
* might want to move to drawRect with combined draw calls for performance reasons — not clear yet
*/

internal class KeyboardKeyShapeView: UIView {

    var shapeLayer: CAShapeLayer?

    override class func layerClass() -> AnyClass {
        return CAShapeLayer.self
    }
    convenience init() {
        self.init(frame: CGRectZero)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.userInteractionEnabled = false
        self.shapeLayer = self.layer as? CAShapeLayer

        // optimization: off by default to ensure quick mode transitions; re-enable during rotations
        //self.layer.shouldRasterize = true
        //self.layer.rasterizationScale = UIScreen.mainScreen().scale
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    var curve: UIBezierPath? {
        didSet {
            if let layer = self.shapeLayer {
                layer.path = curve?.CGPath
            }
            else {
                self.setNeedsDisplay()
            }
        }
    }

    var fillColor: UIColor? {
        didSet {
            if let layer = self.shapeLayer {
                layer.fillColor = fillColor?.CGColor
            }
            else {
                self.setNeedsDisplay()
            }
        }
    }

    var strokeColor: UIColor? {
        didSet {
            if let layer = self.shapeLayer {
                layer.strokeColor = strokeColor?.CGColor
            }
            else {
                self.setNeedsDisplay()
            }
        }
    }

    var lineWidth: CGFloat? {
        didSet {
            if let layer = self.shapeLayer {
                if let lineWidth = self.lineWidth {
                    layer.lineWidth = lineWidth
                }
            }
            else {
                self.setNeedsDisplay()
            }
        }
    }
    
    func drawCall(rect:CGRect) {
        if self.shapeLayer == nil {
            if let curve = self.curve {
                if let lineWidth = self.lineWidth {
                    curve.lineWidth = lineWidth
                }

                if let fillColor = self.fillColor {
                    fillColor.setFill()
                    curve.fill()
                }

                if let strokeColor = self.strokeColor {
                    strokeColor.setStroke()
                    curve.stroke()
                }
            }
        }
    }

    //    override func drawRect(rect: CGRect) {
    //        if self.shapeLayer == nil {
    //            self.drawCall(rect)
    //        }
    //    }
}
