//
//  KeyboardEmojiCategoryView.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 5/31/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import UIKit


public class KeyboardEmojiCategoryView: KeyboardDrawableView {

    public static func classForEmojiCategory(emojiCategory: KeyboardEmojiCategory) -> KeyboardEmojiCategoryView.Type {
        switch emojiCategory {
        case .People:
            return KeyboardPeopleEmojiCategoryView.self
        case .Nature:
            return KeyboardNatureEmojiCategoryView.self
        case .Foods:
            return KeyboardFoodsEmojiCategoryView.self
        case .Activity:
            return KeyboardActivityEmojiCategoryView.self
        case .Places:
            return KeyboardPlacesEmojiCategoryView.self
        case .Objects:
            return KeyboardObjectsEmojiCategoryView.self
        case .Symbols:
            return KeyboardSymbolsEmojiCategoryView.self
        case .Flags:
            return KeyboardFlagsEmojiCategoryView.self
        default:
            fatalError("Not implemented.")
        }
    }

    public var emojiCategory: KeyboardEmojiCategory {
        fatalError("`emojiCategory` has to be implemented in subclasses.")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.opaque = false
    }

    public required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func drawSelection() {
        let ovalPath = UIBezierPath(ovalInRect: CGRectMake(-12, -12, 24, 24))
        UIColor.grayColor().setFill()
        ovalPath.fill()
    }

    public override var highlighted: Bool {
        didSet {
            self.alpha = self.highlighted ? 0.5 : 1.0
        }
    }

    public override var selected: Bool {
        didSet {
            self.setNeedsDisplay()
        }
    }

    public var selectedTintColor: UIColor = UIColor.clearColor()
    public var selectedCircleTintColor: UIColor = UIColor.clearColor()

    public override var tintColor: UIColor! {
        get {
            return self.selected ? self.selectedTintColor : super.tintColor
        }

        set {
            super.tintColor = newValue
        }
    }

    internal override func draw() {
        if self.selected {
            let circlePath = UIBezierPath(ovalInRect: CGRectMake(-13, -13, 26, 26))
            self.selectedCircleTintColor.setFill()
            circlePath.fill()
        }
    }

}
