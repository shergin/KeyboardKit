//
//  KeyboardNumericKeyView.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 8/3/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import UIKit


internal final class KeyboardNumericKeyView: UIControl {

    internal var keyType: KeyboardNumericKeyType = .Nothing { didSet { self.update() } }

    private var titleView: UILabel?
    private var subtitleView: UILabel?
    private var symbolView: UIView?

    internal var appearanceManager: KeyboardAppearanceManager = defaultAppearanceManager {
        didSet {
            self.updateAppearance()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.exclusiveTouch = false
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        var bounds = self.bounds

        if
            let titleView = self.titleView,
            let subtitleView = self.subtitleView
        {

            titleView.sizeToFit()
            subtitleView.sizeToFit()

            let verticalMargin = CGFloat(0)

            var titleFrame = titleView.frame
            var subtitleFrame = subtitleView.frame

            let complexHeight = (subtitleView.text ?? "").isEmpty ? titleFrame.height : titleFrame.height + verticalMargin + subtitleFrame.height

            titleFrame.origin = CGPoint(
                x: ((bounds.size.width - titleFrame.size.width) / 2).rounded(),
                y: ((bounds.size.height - complexHeight) / 2).rounded()
            )

            subtitleFrame.origin = CGPoint(
                x: ((bounds.size.width - subtitleFrame.size.width) / 2).rounded(),
                y: titleFrame.maxY + verticalMargin
            )

            titleView.frame = titleFrame
            subtitleView.frame = subtitleFrame
        }

        if let symbolView = self.symbolView {
            symbolView.frame = bounds
        }
    }

    override var highlighted: Bool {
        didSet {
            self.updateAppearance()
        }
    }

    private func update() {
        self.hidden = false
        self.titleView?.removeFromSuperview()
        self.subtitleView?.removeFromSuperview()
        self.symbolView?.removeFromSuperview()

        switch self.keyType {
        case .Number(let number, let letters):
            let titleView = UILabel()
            titleView.text = String(number)
            self.addSubview(titleView)

            let subtitleView = UILabel()
            subtitleView.text = letters
            self.addSubview(subtitleView)

            self.titleView = titleView
            self.subtitleView = subtitleView
            break

        case .Backspace:
            let symbolView = KeyboardKeyBackspaceSymbolView()
            symbolView.userInteractionEnabled = false
            self.addSubview(symbolView)
            self.symbolView = symbolView
            break

        case .Nothing:
            self.hidden = true
            break
        }
    }

    private func updateAppearance() {
        var keyAppearanceVariant = KeyboardKeyAppearanceVariant.suitable()

        keyAppearanceVariant.keyColorType = self.keyType.isSpecial ? .Special : .Regular

        keyAppearanceVariant.keyMode.highlightMode = self.highlighted ? .Highlighted : .None

        let appearance = self.appearanceManager.appearanceForVariant(keyAppearanceVariant)

        self.backgroundColor = appearance.keycapBodyColor

        self.titleView?.textColor = appearance.keycapTextColor
        self.subtitleView?.textColor = appearance.keycapTextColor

        self.titleView?.font = appearance.keycapTextFont
        self.subtitleView?.font = appearance.keycapTextFont?.fontWithSize(10.0)

        self.symbolView?.tintColor = appearance.keycapTextColor
    }

}
