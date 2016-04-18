//
//  KeyboardContentView.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 2/11/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import UIKit


public class KeyboardContentView: UIView {
    public override class func requiresConstraintBasedLayout() -> Bool {
        return true
    }

    /*
//    public override func sizeThatFits(size: CGSize) -> CGSize {
//        return CGSize(width: size.width, height: 350.0)
//    }


    public override func layoutSubviews() {
        super.layoutSubviews()
    }
*/
    public override func intrinsicContentSize() -> CGSize {
        var intrinsicContentSize = super.intrinsicContentSize()
        //intrinsicContentSize.width = self.superview!.frame.size.width
        return intrinsicContentSize
    }
}
