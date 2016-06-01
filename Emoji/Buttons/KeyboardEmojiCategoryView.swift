//
//  KeyboardEmojiCategoryView.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 5/31/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation


public class KeyboardEmojiCategoryView: UIControl {

    public static func classForEmojiCategory(emojiCategory: KeyboardEmojiCategory) -> KeyboardEmojiCategoryView.Type {
        switch emojiCategory {
        case .People:
            return KeyboardPeopleEmojiCategoryView.self
        case .Nature:
            return KeyboardNatureEmojiCategoryView.self
        case .Foods:
            return KeyboardFoodEmojiCategoryView.self
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

    class var size: CGSize {
        return CGSize(width: 32.0, height: 32.0)
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

    func draw() {
        fatalError("draw() has to be implemented in subclasses.")
    }

    public override var highlighted: Bool {
        didSet {
            self.alpha = self.highlighted ? 0.5 : 1.0
        }
    }

}
