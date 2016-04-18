//
//  KeyboardKeySymbolView.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 1/12/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation

public class KeyboardKeySymbolView: UIView {

    // in case shapes draw out of bounds, we still want them to show
    var overflowCanvas: KeyboardShapeOverflowCanvasView!

    convenience init() {
        self.init(frame: CGRectZero)
    }

    public override required init(frame: CGRect) {
        super.init(frame: frame)

        self.opaque = false
        self.clipsToBounds = false

        self.overflowCanvas = KeyboardShapeOverflowCanvasView(shapeView: self)
        self.addSubview(self.overflowCanvas)
    }

    required public init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override var tintColor: UIColor! {
        didSet {
            self.setNeedsDisplay()
        }
    }

    public override func setNeedsDisplay() {
        super.setNeedsDisplay()

        if let overflowCanvas = self.overflowCanvas {
            overflowCanvas.setNeedsDisplay()
        }
    }

    var oldBounds: CGRect?
    override public func layoutSubviews() {
        if self.bounds.width == 0 || self.bounds.height == 0 {
            return
        }
        if oldBounds != nil && CGRectEqualToRect(self.bounds, oldBounds!) {
            return
        }
        oldBounds = self.bounds

        super.layoutSubviews()

        let overflowCanvasSizeRatio = CGFloat(1.25)
        let overflowCanvasSize = CGSizeMake(self.bounds.width * overflowCanvasSizeRatio, self.bounds.height * overflowCanvasSizeRatio)

        self.overflowCanvas.frame = CGRectMake(
            CGFloat((self.bounds.width - overflowCanvasSize.width) / 2.0),
            CGFloat((self.bounds.height - overflowCanvasSize.height) / 2.0),
            overflowCanvasSize.width,
            overflowCanvasSize.height)

        self.overflowCanvas.setNeedsDisplay()
    }

    func drawCall(color: UIColor) {
        let ctx = UIGraphicsGetCurrentContext()
        CGContextSaveGState(ctx)
        CGContextTranslateCTM(ctx, self.bounds.size.width / 2.0, self.bounds.size.height / 2.0)

        self.drawSymbol()

        CGContextRestoreGState(UIGraphicsGetCurrentContext())
    }

    // # Public

    public class func symbolPath() -> UIBezierPath! {
        return nil
    }

    public func drawSymbol() {
        if let sumbolPath = self.dynamicType.symbolPath() {
            self.tintColor.setFill()
            sumbolPath.fill()
        }
    }
}


/////////////////////
// SHAPE FUNCTIONS //
/////////////////////

func getFactors(fromSize: CGSize, toRect: CGRect) -> (xScalingFactor: CGFloat, yScalingFactor: CGFloat, lineWidthScalingFactor: CGFloat, fillIsHorizontal: Bool, offset: CGFloat) {

    let xSize = { () -> CGFloat in
        let scaledSize = (fromSize.width / CGFloat(2))
        if scaledSize > toRect.width {
            return (toRect.width / scaledSize) / CGFloat(2)
        }
        else {
            return CGFloat(0.5)
        }
    }()

    let ySize = { () -> CGFloat in
        let scaledSize = (fromSize.height / CGFloat(2))
        if scaledSize > toRect.height {
            return (toRect.height / scaledSize) / CGFloat(2)
        }
        else {
            return CGFloat(0.5)
        }
    }()

    let actualSize = min(xSize, ySize)

    return (actualSize, actualSize, actualSize, false, 0)
}

func centerShape(fromSize: CGSize, toRect: CGRect) {
    let xOffset = (toRect.width - fromSize.width) / CGFloat(2)
    let yOffset = (toRect.height - fromSize.height) / CGFloat(2)

    let ctx = UIGraphicsGetCurrentContext()
    CGContextSaveGState(ctx)
    CGContextTranslateCTM(ctx, xOffset, yOffset)
}

func endCenter() {
    let ctx = UIGraphicsGetCurrentContext()
    CGContextRestoreGState(ctx)
}
