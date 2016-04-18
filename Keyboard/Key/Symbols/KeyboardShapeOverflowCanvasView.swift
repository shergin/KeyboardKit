//
//  KeyboardShapeOverflowCanvasView.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 1/12/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import UIKit

internal class KeyboardShapeOverflowCanvasView: UIView {
    private weak var shapeView: KeyboardKeySymbolView?

    internal init(shapeView: KeyboardKeySymbolView) {
        self.shapeView = shapeView

        super.init(frame: CGRectZero)

        self.opaque = false
    }

    internal required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    internal override func drawRect(rect: CGRect) {
        guard let shapeView = self.shapeView else {
            return
        }

        let context = UIGraphicsGetCurrentContext()

        CGContextSaveGState(context)

        let xOffset = (self.bounds.width - shapeView.bounds.width) / CGFloat(2)
        let yOffset = (self.bounds.height - shapeView.bounds.height) / CGFloat(2)

        CGContextTranslateCTM(context, xOffset, yOffset)

        shapeView.drawCall(shapeView.tintColor ?? UIColor.blackColor())

        CGContextRestoreGState(context)
    }
}
