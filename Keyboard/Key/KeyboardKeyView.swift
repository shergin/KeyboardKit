//
//  KeyboardKeyView.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 1/12/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import UIKit

public class KeyboardKeyView: UIControl {

    // # Shapes
    private(set) var keyShape: KeyboardKeyShape!
    private(set) var connectorShape: KeyboardConnectorShape?
    private(set) var popupShape: KeyboardPopupShape?

    // # Behaviour and Modes
    public var key: KeyboardKey = KeyboardKey() { didSet { if oldValue != self.key {
        self.needsUpdateKey = true
        self.needsUpdateAppearance = true
    } } }
    public var keyMode: KeyboardKeyMode = KeyboardKeyMode() { didSet { if oldValue != self.keyMode {
        self.needsUpdateKeyMode = true
        self.needsUpdateAppearance = true
    } } }
    public var keyboardMode: KeyboardMode = KeyboardMode() { didSet { if oldValue != self.keyboardMode {
        self.needsUpdateKeyboardMode = true
        self.needsUpdateKey = true
        self.needsUpdateAppearance = true
    } } }
    public var appearance: KeyboardKeyAppearance = KeyboardKeyAppearance() { didSet { if oldValue != self.appearance {
        self.needsUpdateAppearance = true
    } } }

    private var needsUpdateKey: Bool = true
    private var needsUpdateKeyMode: Bool = true
    private var needsUpdateKeyboardMode: Bool = true
    private var needsUpdateAppearance: Bool = true

    public var appearanceManager: KeyboardAppearanceManager?

    public var appearanceVariant: KeyboardKeyAppearanceVariant {
        var appearanceVariant = KeyboardKeyAppearanceVariant(
            keyType: self.key.type,
            keyColorType: self.key.colorType,
            popupType: self.key.popupType,
            keyMode: self.keyMode,
            keyboardMode: self.keyboardMode
        )
        appearanceVariant.synchronizeModes()
        return appearanceVariant
    }

    private var labelInset: CGFloat = 0 {
        didSet {
            if oldValue != labelInset {
                self.setNeedsLayout()
            }
        }
    }

    private var zIndexed: Bool = false {
        didSet {
            self.layer.zPosition = self.zIndexed ? 1000 : 0
        }
    }

    private var contentVisible: Bool = true {
        didSet {
            self.labelView.hidden = !self.contentVisible
            self.contentView?.hidden = !self.contentVisible
        }
    }

    public var shouldRasterize: Bool = false {
        didSet {
            for view in [self.displayView, self.borderView, self.underView, self.labelView as? UIView] where view != nil {
                view!.layer.shouldRasterize = shouldRasterize
                view!.layer.rasterizationScale = UIScreen.mainScreen().scale
            }

            self.labelView.layer.shouldRasterize = shouldRasterize
            self.labelView.layer.rasterizationScale = UIScreen.mainScreen().scale

        }
    }

    // # Views
    private var labelView: UILabel // TODO: Use optional here!
    private var shadowView: UIView
    private var shadowLayer: CALayer

    private var displayView: KeyboardKeyShapeView
    private var popupView: KeyboardKeyPopupView?
    private var borderView: KeyboardKeyShapeView?
    private var underView: KeyboardKeyShapeView?

    private var contentView: UIView? {
        willSet {
            self.contentView?.removeFromSuperview()
        }
        didSet {
            if let contentView = self.contentView {
                contentView.contentMode = .ScaleAspectFit
                contentView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
                contentView.frame = self.bounds
                self.addSubview(contentView)
            }
        }
    }

    public override init(frame: CGRect) {
        self.displayView = KeyboardKeyShapeView()
        self.underView = KeyboardKeyShapeView()
        self.borderView = KeyboardKeyShapeView()

        self.shadowLayer = CAShapeLayer()
        self.shadowView = UIView()
        self.labelView = UILabel()

        super.init(frame: frame)

        self.keyShape = KeyboardKeyShape()

        self.shadowView.userInteractionEnabled = false
        self.addSubview(self.shadowView)
        self.shadowView.layer.addSublayer(self.shadowLayer)

        self.addSubview(self.displayView)
        if let underView = self.underView {
            self.addSubview(underView)
        }

        if let borderView = self.borderView {
            self.addSubview(borderView)
        }

        self.addSubview(self.labelView)

        self.displayView.opaque = false
        self.underView?.opaque = false
        self.borderView?.opaque = false

        self.shadowLayer.shadowOpacity = Float(0.2)
        self.shadowLayer.shadowRadius = 4
        self.shadowLayer.shadowOffset = CGSizeMake(0, 3)

        self.borderView?.lineWidth = CGFloat(0.5)
        self.borderView?.fillColor = UIColor.clearColor()

        self.labelView.textAlignment = NSTextAlignment.Center
        self.labelView.baselineAdjustment = UIBaselineAdjustment.AlignCenters
        self.labelView.adjustsFontSizeToFitWidth = true
        self.labelView.minimumScaleFactor = CGFloat(0.1)
        self.labelView.userInteractionEnabled = false
        self.labelView.numberOfLines = 1
    }

    public required init?(coder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    public override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
        // This is simplified and optimised version of UIResponder's `hitTest`.
        guard self.userInteractionEnabled && !self.hidden && self.alpha > 0 else {
            return nil
        }

        // Is this event inside our frame?
        if self.pointInside(point, withEvent:event) {
            return self
        }

        // Is this event inside interactive popup?
        if let _ = self.popupView as? KeyboardKeyAlternateKeysPopupView {
            if self.boundingBounds().contains(point) {
                return self
            }
        }

        return nil
    }

    private func boundingBounds() -> CGRect {
        return self.popupView != nil ? CGRectUnion(self.bounds, self.popupView!.frame) : self.bounds
    }

    var oldBounds: CGRect?
    override public func layoutSubviews() {
        self.layoutPopupIfNeeded()

        let boundingBox = (self.popupView != nil ? CGRectUnion(self.bounds, self.popupView!.frame) : self.bounds)

        if self.bounds.width == 0 || self.bounds.height == 0 {
            return
        }
        if oldBounds != nil && CGSizeEqualToSize(boundingBox.size, oldBounds!.size) {
            return
        }
        oldBounds = boundingBox

        super.layoutSubviews()

        CATransaction.begin()
        CATransaction.setDisableActions(true)

        self.labelView.frame = CGRectMake(self.labelInset, self.labelInset, self.bounds.width - self.labelInset * 2, self.bounds.height - self.labelInset * 2)

        self.displayView.frame = boundingBox
        self.shadowView.frame = boundingBox
        self.borderView?.frame = boundingBox
        self.underView?.frame = boundingBox

        let boundingView = self.displayView

        // Update shapes
        self.keyShape.bounds = boundingView.convertRect(self.bounds, fromView: self)
        if let popupShape = self.popupShape, let popupView = self.popupView {
            popupShape.bounds = boundingView.convertRect(popupView.bounds, fromView: popupView)
            fixIntersection(self.keyShape, second: popupShape)
        }

        self.connectorShape?.needRecreatePaths = true

        CATransaction.commit()

        self.refreshViews()
    }

    public override func didMoveToWindow() {
        super.didMoveToWindow()
        self.updateIfNeeded()
    }

    func refreshViews() {
        self.refreshShapes()
    }

    func refreshShapes() {
        CATransaction.begin()
        CATransaction.setDisableActions(true)

        self.keyShape.createPathsIfNeeded()

        var compoundShape: KeyboardShape!

        if let popupShape = self.popupShape, let connectorShape = self.connectorShape {
            popupShape.createPathsIfNeeded()
            connectorShape.createPathsIfNeeded()

            let popupAndConnectorShape = KeyboardShape(shapes: [self.popupShape, self.connectorShape])
            compoundShape = KeyboardShape(shapes: [self.keyShape, popupAndConnectorShape])

            self.shadowLayer.shadowPath = popupAndConnectorShape.fillPath.CGPath
        }
        else {
            compoundShape = self.keyShape
            self.shadowLayer.shadowPath = nil
        }

        self.underView?.curve = compoundShape.underPath
        self.displayView.curve = compoundShape.fillPath
        self.borderView?.curve = compoundShape.edgePath

        CATransaction.commit()
    }

    func layoutPopupIfNeeded() {
        if self.popupView != nil {
            self.shadowView.hidden = false
            //self.borderView?.hidden = false

            self.layoutPopup()
        }
        else {
            self.shadowView.hidden = true
            //self.borderView?.hidden = true
        }
    }

    // # Prepare for reuse

    public func prepareForReuse() {
        self.needsUpdateKey = true
        self.needsUpdateKeyMode = true
        self.needsUpdateKeyboardMode = true
        self.needsUpdateAppearance = true
    }

    // # Updating

    public func updateIfNeeded() {
        let needUpdateAppearance = self.needsUpdateKey || self.needsUpdateKeyboardMode || self.needsUpdateKeyMode

        if let appearanceManager = self.appearanceManager where needUpdateAppearance {
            self.appearance = appearanceManager.appearanceForVariant(self.appearanceVariant)
        }

        self.updateKeyModeIfNeeded()
        self.updateKeyIfNeeded()
        self.updateAppearanceIfNeeded()
    }

    // # Updating `appearance`
    public func updateAppearanceIfNeeded() {
        guard self.needsUpdateAppearance else {
            return
        }

        self.needsUpdateAppearance = false

        self.updateAppearance()
    }

    internal func updateAppearance() {
        let appearance = self.appearance
        CATransaction.begin()
        CATransaction.setDisableActions(true)

        //if self.labelView.font.pointSize != appearance.keycapTextFontSize {
        self.labelView.font = appearance.keycapTextFont
        //}

        let isPopup = self.keyMode.popupMode != .None

        let textColor = isPopup ? appearance.popupTextColor : appearance.keycapTextColor
        let bodyColor = isPopup ? appearance.popupBodyColor : appearance.keycapBodyColor
        let borderColor = isPopup ? appearance.popupBorderColor : appearance.keycapBorderColor
        let outerShadowColor = isPopup ? appearance.popupOuterShadowColor : appearance.keycapOuterShadowColor
        let borderSize = isPopup ? appearance.popupBorderSize : appearance.keycapBorderSize


        self.labelView.textColor = textColor
        self.contentView?.tintColor = textColor

        self.displayView.fillColor = bodyColor
        self.underView?.fillColor = outerShadowColor
        self.borderView?.strokeColor = borderColor

        self.borderView?.lineWidth = borderSize

        if self.popupView != nil {
            self.displayView.fillColor = bodyColor
        }

        if let popupView = self.popupView as? KeyboardKeyPreviewPopupView {
            popupView.labelView.textColor = textColor
        }

        self.keyShape.cornerRadius = self.appearance.bodyCornerRadius
        self.popupShape?.cornerRadius = self.appearance.popupCornerRadius


        if let contentView = self.contentView as? KeyboardKeyContentView {
            contentView.appearance = appearance
        }

        CATransaction.commit()
    }

    // # Updating `key`
    public func updateKeyIfNeeded() {
        guard self.needsUpdateKey else {
            return
        }

        self.needsUpdateKey = false

        self.updateKey()
    }

    private func updateKey() {
        if let label = self.key.label {
            self.labelView.text = label.labelWithShiftMode(self.keyboardMode.shiftMode)
        }
        else {
            self.labelView.text = nil
        }

        if let image = self.key.image {
            self.contentView = image.imageView
        } else if let contentView = self.key.contentView {
            self.contentView = contentView.copy() as! UIView
        } else {
            self.contentView = nil
        }
    }

    // # Updating `keyMode`
    public func updateKeyModeIfNeeded() {
        guard self.needsUpdateKeyMode else {
            return
        }

        self.needsUpdateKeyMode = false

        self.updateKeyMode()
    }

    private func updateKeyMode() {
        let popupMode = self.keyMode.popupMode

        if popupMode == .None {
            self.hidePopup()
        }
        else {
            self.showPopupWithMode(popupMode)
        }
    }

    private func layoutPopup() {
        assert(self.popupView != nil, "Popup not instanciated.")

        if let popup = self.popupView {
            popup.frame = popup.adjustedIntrinsicFrame() //self.adjustPopupFrame(self.frameForPopup())
        }
    }

    public var effectiveKey: KeyboardKey {
        if let key = (self.popupView as? KeyboardKeyAlternateKeysPopupView)?.highlightedKey {
            return key
        }

        return self.key
    }

    private func showPopupWithMode(mode: KeyboardKeyPopupTypeMode) {
        self.hidePopup()

        let direction = self.appearance.popupDirection

        self.popupShape = KeyboardPopupShape(shape: self.keyShape)
        self.popupShape?.cornerRadius = self.appearance.popupCornerRadius // FIXME:

        self.connectorShape = KeyboardConnectorShape(
            begin: (shape: self.keyShape, direction: direction),
            end: (shape: self.popupShape!, direction: direction.opposite())
        )

        switch mode {
        case .Preview:
            let popupView = KeyboardKeyPreviewPopupView()
            popupView.appearance = self.appearance
            popupView.labelView.text = self.labelView.text // FIXME:
            self.popupView = popupView
            break
        case .AlternateKeys:
            let popupView = KeyboardKeyAlternateKeysPopupView()
            popupView.appearance = self.appearance
            popupView.alternateKeys = self.key.alternateKeys
            self.popupView = popupView
            break
        default:
            assertionFailure("KeyboardKeyView: Wrong popupMode.")
        }

        self.addSubview(self.popupView!)

        self.contentVisible = false
        self.zIndexed = true

        self.needsUpdateAppearance = true
    }

    private func hidePopup() {
        guard self.popupView != nil else {
            return
        }

        self.connectorShape = nil
        self.popupShape = nil

        self.popupView!.removeFromSuperview()
        self.popupView = nil

        self.contentVisible = true
        self.zIndexed = false

        self.needsUpdateAppearance = true
    }

}
