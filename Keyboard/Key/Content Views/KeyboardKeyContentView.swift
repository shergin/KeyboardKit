//
//  KeyboardKeyContentView.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 4/4/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import UIKit


public class KeyboardKeyContentView: UIView {
/*
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }

    public convenience init() {
        self.init(frame: CGRectZero)
    }

    public required init(_ contentView: KeyboardKeyContentView) {
        super.init(frame: contentView.frame)
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
*/


    public var appearance: KeyboardKeyAppearance = KeyboardKeyAppearance()
}


extension KeyboardKeyContentView: NSCopying {
    public func copyWithZone(zone: NSZone) -> AnyObject {
        fatalError("copyWithZone(zone:) has not been implemented")
    }
}
