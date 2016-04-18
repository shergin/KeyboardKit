//
//  KeyboardSuggestionItemView.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 2/11/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import UIKit


internal final class KeyboardSuggestionItemView: UIControl {

    internal var appearanceManager: KeyboardAppearanceManager?

    var labelView: UILabel!
    var item: KeyboardSuggestionGuess! {
        didSet {
            guard oldValue != self.item else {
                return
            }

            self.invalidateSuggestionItem()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.labelView = UILabel()
        self.labelView.lineBreakMode = .ByTruncatingHead
        self.addSubview(self.labelView)

        self.layer.cornerRadius = 2.0
        self.layer.masksToBounds = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let horizontalPadding = CGFloat(4.0)
        let verticalPadding = CGFloat(1.0)

        var labelFrame = self.bounds
        labelFrame.insetInPlace(dx: horizontalPadding, dy: verticalPadding)

        let size = self.labelView.sizeThatFits(labelFrame.size)
        let width = min(size.width, labelFrame.size.width)
        labelFrame.size.width = width
        self.labelView.frame = labelFrame
        self.labelView.center = CGPoint(x: self.bounds.size.width / 2, y: self.bounds.size.height / 2)
    }

    private func updateStyle() {
        guard let appearanceManager = self.appearanceManager else {
            return
        }

        var appearanceVariant = KeyboardKeyAppearanceVariant.suitable()

        //appearanceVariant.keyColorType = self.item.highlighted ? .Regular : .Special
        appearanceVariant.keyColorType = .Special
        appearanceVariant.keyMode.selectionMode = self.item.appearance.highlighted ? .Selected : .None
        //appearanceVariant.keyMode.highlightMode = self.item.highlighted ? .Highlighted : .None

        let appearance = appearanceManager.appearanceForVariant(appearanceVariant)

        let bodyColor = appearance.keycapBodyColor
        let textColor = appearance.keycapTextColor

        self.backgroundColor = bodyColor//.colorWithAlphaComponent(0.5)
        self.layer.borderColor = appearance.keycapBorderColor.CGColor
        self.layer.borderWidth = appearance.keycapBorderSize
        //self.layer.cornerRadius = appearance.keycapCornerRadius
        self.labelView.textColor = textColor
    }

    internal func invalidateSuggestionItem() {
        let text = self.item.appearance.quoted ? "“\(self.item.replacement)”" : self.item.replacement

        //UIView.transitionWithView(self.labelView, duration: 0.25, options: .TransitionCrossDissolve, animations: { () -> Void in
            self.labelView.text = text
        //}, completion: nil)

        self.updateStyle()

        self.setNeedsLayout()
    }

}
