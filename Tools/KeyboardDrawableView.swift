//
//  KeyboardDrawableView.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 6/1/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import UIKit


public  class KeyboardDrawableView: UIControl {
    public class var size: CGSize {
        return CGSize(width: 32.0, height: 32.0)
    }

    public override func intrinsicContentSize() -> CGSize {
        return self.dynamicType.size
    }

    public override func sizeThatFits(size: CGSize) -> CGSize {
        return self.dynamicType.size
    }

    public override var tintColor: UIColor! {
        didSet {
            self.setNeedsDisplay()
        }
    }

    public override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()

        CGContextSaveGState(context)

        let xOffset = self.bounds.width / CGFloat(2)
        let yOffset = self.bounds.height / CGFloat(2)

        CGContextTranslateCTM(context, xOffset, yOffset)

        self.draw()

        CGContextRestoreGState(context)
    }
    
    internal func draw() {
    }
    
}
