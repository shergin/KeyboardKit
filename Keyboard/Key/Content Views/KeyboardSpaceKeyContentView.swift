//
//  KeyboardSpaceKeyContentView.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 4/4/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import UIKit


public final class KeyboardSpaceKeyContentView: KeyboardKeyContentView {

    public var labelView: UILabel!
    public var pageControlView: KeyboardSpaceKeyPageControlView!

    public override init(frame: CGRect) {
        super.init(frame: frame)

        self.labelView = UILabel()
        self.labelView.text = "Space"
        self.addSubview(self.labelView)


        self.pageControlView = KeyboardSpaceKeyPageControlView()
        self.pageControlView.transform = CGAffineTransformMakeScale(0.5, 0.5);
//        self.pageControlView.pageIndicatorTintColor = UIColor.blackColor()
//        self.pageControlView.currentPageIndicatorTintColor = UIColor.whiteColor()
//        self.pageControlView.backgroundColor = UIColor.brownColor()
        self.addSubview(self.pageControlView)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public var appearance: KeyboardKeyAppearance {
        didSet {
            let color = self.appearance.keycapTextColor
            self.pageControlView.pageIndicatorTintColor = color.colorWithAlphaComponent(0.2)
            self.pageControlView.currentPageIndicatorTintColor = color

            self.labelView.font = appearance.keycapTextFont
            self.labelView.textColor = appearance.keycapTextColor
        }
    }

    public override func layoutSubviews() {
        super.layoutSubviews()

        self.labelView.sizeToFit()
        self.labelView.center = CGPoint(x: self.bounds.midX, y: self.bounds.midY - 3.0)

        self.pageControlView.frame = CGRect(
            origin: CGPointZero,
            size: CGSize(width: self.bounds.size.width, height: 4.0))
        self.pageControlView.frame.origin.y = self.bounds.size.height - 8.0 - 2.0
    }

}


extension KeyboardSpaceKeyContentView {
    public override func copyWithZone(zone: NSZone) -> AnyObject {
        // TODO: Add required init
        //let contentView = self.dynamicType.init(frame: self.frame)
        let contentView = KeyboardSpaceKeyContentView(frame: self.frame)

        contentView.pageControlView.numberOfPages = self.pageControlView.numberOfPages
        contentView.pageControlView.currentPage = self.pageControlView.currentPage

        return contentView
    }
}


public final class KeyboardSpaceKeyPageControlView: UIPageControl {

    public override func sizeForNumberOfPages(pageCount: Int) -> CGSize {
        return CGSize(width: pageCount * 30, height: 10)
    }

}