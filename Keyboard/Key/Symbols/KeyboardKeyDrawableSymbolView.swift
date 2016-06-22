//
//  KeyboardKeyDrawableSymbolView.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 6/20/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import UIKit


public class KeyboardKeyDrawableSymbolView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.opaque = false
    }

    public required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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

    func draw() {
        fatalError("")
    }
}
