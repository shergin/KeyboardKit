//
//  KeyboardKeyPopupView.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 1/18/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import UIKit


internal class KeyboardKeyPopupView: UIView {

    internal var appearance: KeyboardKeyAppearance!

    internal weak var keyView: KeyboardKeyView?

    override func didMoveToSuperview() {
        super.didMoveToSuperview()

        if self.keyView != nil {
            self.willDeactivate()
        }

        self.keyView = self.superview as? KeyboardKeyView

        if self.keyView != nil {
            self.didActivate()
        }
    }

    internal func didActivate() {
    }

    internal func willDeactivate() {
    }

    internal func intrinsicFrame() -> CGRect {
        let size = self.intrinsicContentSize()
        let keyViewSize = self.keyView!.bounds.size

        let origin = CGPoint(
            x: (keyViewSize.width - size.width) / CGFloat(2),
            y: -size.height - LayoutConstants.popupGap
        )

        return CGRect(origin: origin, size: size)
    }

    internal func adjustedIntrinsicFrame() -> CGRect {
        return self.adjustFrame(self.intrinsicFrame())
    }

    internal func adjustFrame(frame: CGRect) -> CGRect {
        let minimalPadding = CGPoint(x: 3, y: 3)
        let window = self.window!

        var popupFrameToWindow = window.convertRect(frame, fromView: self)
        let keyFrameToWindow = window.convertRect(self.bounds, fromView: self)

        // Top edge
        if popupFrameToWindow.origin.y < minimalPadding.y {
            popupFrameToWindow.origin.y = min(keyFrameToWindow.origin.y, minimalPadding.y)
        }

        // Left edge
        if popupFrameToWindow.origin.x < minimalPadding.x {
            popupFrameToWindow.origin.x = min(keyFrameToWindow.origin.x, minimalPadding.x)
        }

        // Right edge
        if popupFrameToWindow.origin.x + popupFrameToWindow.width > window.bounds.width - minimalPadding.x {
            popupFrameToWindow.origin.x = max(
                keyFrameToWindow.origin.x + keyFrameToWindow.size.width - popupFrameToWindow.width,
                window.bounds.width - popupFrameToWindow.width - minimalPadding.x
            )
        }

        // Bottom edge
        // TODO: Implement me, please.

        return window.convertRect(popupFrameToWindow, toView: self)
    }

    override func intrinsicContentSize() -> CGSize {
        // TODO: Rethink and refactor
        let actualScreenWidth = UIScreen.mainScreen().nativeBounds.size.width / UIScreen.mainScreen().nativeScale
        let totalHeight = LayoutConstants.popupTotalHeight(actualScreenWidth)
        let popupGap = LayoutConstants.popupGap

        let size = CGSize(
            width: self.superview!.bounds.width + LayoutConstants.popupWidthIncrement,
            height: totalHeight - popupGap - self.superview!.frame.size.height
        )

        return size
    }

}