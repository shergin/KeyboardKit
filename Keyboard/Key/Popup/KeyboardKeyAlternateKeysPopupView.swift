//
//  KeyboardKeyAlternateKeysPopupView.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 3/8/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import UIKit


internal final class KeyboardKeyAlternateKeysPopupView: KeyboardKeyPopupView {
    internal var alternateKeys: [KeyboardKey]! {
        didSet {
            self.updateAlternateKeyViews()
        }
    }

    private var alternateKeyViews: [KeyboardAlternateKeyView] = []

    internal override init(frame: CGRect) {
        super.init(frame: frame)
    }

    internal required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    internal var highlightedKey: KeyboardKey? {
        return self.alternateKeyViews.filter { $0.highlighted }.first?.key
    }

    internal override func intrinsicFrame() -> CGRect {
        let isLeft = self.keyView!.center.x > self.keyView!.superview!.center.x

        var frame = super.intrinsicFrame()

        let offset = LayoutConstants.popupWidthIncrement / CGFloat(2)
        
        frame.origin.x = (
            isLeft ?
                self.keyView!.bounds.maxX - frame.size.width + offset:
                self.keyView!.bounds.minX - offset).rounded()

        return frame
    }

    func updateAlternateKeyViews() {
        for view in self.alternateKeyViews {
            view.removeFromSuperview()
        }

        self.alternateKeyViews.removeAll()

        for key in self.alternateKeys {
            let alternateKeyView = KeyboardAlternateKeyView()
            alternateKeyView.appearance = self.appearance
            alternateKeyView.key = key
            self.alternateKeyViews.append(alternateKeyView)
            self.addSubview(alternateKeyView)
        }

        self.alternateKeyViews.first!.highlighted = true
    }

    private var keyMargin: CGPoint {
        return CGPoint(x: 2, y: 0)
    }

    private var keysPadding: CGPoint {
        return CGPoint(x: LayoutConstants.popupWidthIncrement / CGFloat(2), y: 8)
    }

    override func sizeThatFits(baseSize: CGSize) -> CGSize {
        let paddingX = self.keyMargin.x

        let width = self.alternateKeyViews.reduce(0.0) { (width, alternateKeyView) -> CGFloat in
            return alternateKeyView.sizeThatFits(CGSizeZero).width + width + paddingX
        } - paddingX + self.keysPadding.x * 2

        return CGSize(width: width, height: baseSize.height)
    }

    override func intrinsicContentSize() -> CGSize {
        return self.sizeThatFits(super.intrinsicContentSize())
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        var frame = self.bounds.insetBy(dx: self.keysPadding.x, dy: self.keysPadding.y)

        for alternateKeyView in self.alternateKeyViews {
            frame.size.width = alternateKeyView.sizeThatFits(CGSizeZero).width
            alternateKeyView.frame = frame
            frame.origin.x = frame.maxX + self.keyMargin.x
        }
    }

    internal override func didActivate() {
        self.addTargets()
    }

    internal override func willDeactivate() {
        self.removeTargets()
    }

    func addTargets() {
        self.keyView!.addTarget(self, action: Selector("keyViewDidTouchDragInside:event:"), forControlEvents: .TouchDragInside)
        self.keyView!.addTarget(self, action: Selector("keyViewDidTouchUpInside:event:"), forControlEvents: .TouchUpInside)
    }

    func removeTargets() {
        self.keyView?.removeTarget(self, action: nil, forControlEvents: [.TouchDragInside, .TouchUpInside])
    }

    internal dynamic func keyViewDidTouchDragInside(keyView: KeyboardKeyView, event: UIEvent?) {
        guard let touch = event?.allTouches()?.first else {
            return
        }

        let point = touch.locationInView(self)

        for alternateKeyView in self.alternateKeyViews {
            let frame = alternateKeyView.frame
            alternateKeyView.highlighted = point.x > frame.minX && point.x < frame.maxX
        }
    }

    internal dynamic func keyViewDidTouchUpInside(keyView: KeyboardKeyView, event: UIEvent?) {
    }

}
