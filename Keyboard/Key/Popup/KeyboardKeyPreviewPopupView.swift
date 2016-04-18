//
//  KeyboardKeyPreviewPopupView.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 3/8/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation

internal final class KeyboardKeyPreviewPopupView: KeyboardKeyPopupView {

    internal var labelView: UILabel!

    internal override init(frame: CGRect) {
        super.init(frame: frame)

        self.labelView = UILabel(frame: self.bounds)
        self.labelView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        self.labelView.textAlignment = .Center
        self.labelView.baselineAdjustment = .AlignCenters // TODO: Rethink!
        self.labelView.font = UIFont.systemFontOfSize(44.0)
        self.labelView.adjustsFontSizeToFitWidth = true
        self.labelView.minimumScaleFactor = CGFloat(0.1)
        self.labelView.userInteractionEnabled = false
        self.labelView.numberOfLines = 1
        self.labelView.frame = self.bounds
        self.addSubview(self.labelView)
    }

    internal required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
