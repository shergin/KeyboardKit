//
//  KeyboardKeyAppearance.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 1/14/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation


public struct KeyboardKeyAppearance {
    // # Keycap
    public var keycapBodyColor: UIColor = UIColor.lightGrayColor()
    public var keycapTextColor: UIColor = UIColor.blackColor()
    public var keycapOuterShadowColor: UIColor = UIColor.darkGrayColor()
    public var keycapBorderColor: UIColor = UIColor.blackColor()
    public var keycapBorderSize: CGFloat = 0

    // # Popup
    public var popupBodyColor: UIColor = UIColor.lightGrayColor()
    public var popupTextColor: UIColor = UIColor.blackColor()
    public var popupOuterShadowColor: UIColor = UIColor.darkGrayColor()
    public var popupBorderColor: UIColor = UIColor.blackColor()
    public var popupBorderSize: CGFloat = 0
    public var popupHighlightedBackgroundColor: UIColor = UIColor.blackColor()
    public var popupHighlightedTextColor: UIColor = UIColor.lightGrayColor()

    // # Font sizes
    public var keycapTextFont = UIFont(name: "HelveticaNeue", size: 16)
    public var popupTextFont = UIFont(name: "HelveticaNeue", size: 32)

    // # Flags
    public var drawUnder: Bool = true // TODO: Rename with 'hasXXXX'.
    public var drawOver: Bool = false
    public var drawBorder: Bool = false

    // # Metrics
    public var underOffset: CGPoint = CGPoint(x: 0, y: 3.0)
    public var popupCornerRadius: CGFloat = 9.0
    public var bodyCornerRadius: CGFloat = 4.0

    // # Popup
    public var popupDirection: KeyboardDirection = .Up

    // # Behaviour
    public var shouldShowPreviewPopup: Bool = false
    public var shouldHighlight: Bool = false
}


// # Equatable
extension KeyboardKeyAppearance: Equatable {
}

public func ==(lhs: KeyboardKeyAppearance, rhs: KeyboardKeyAppearance) -> Bool {
    return
        lhs.keycapBodyColor == rhs.keycapBodyColor &&
        lhs.keycapTextColor == rhs.keycapTextColor &&
        lhs.keycapOuterShadowColor == rhs.keycapOuterShadowColor &&
        lhs.keycapBorderColor == rhs.keycapBorderColor &&

        lhs.popupBodyColor == rhs.popupBodyColor &&
        lhs.popupTextColor == rhs.popupTextColor &&
        lhs.popupOuterShadowColor == rhs.popupOuterShadowColor &&
        lhs.popupBorderColor == rhs.popupBorderColor &&
        lhs.popupHighlightedBackgroundColor == rhs.popupHighlightedBackgroundColor &&
        lhs.popupHighlightedTextColor == rhs.popupHighlightedTextColor &&

        lhs.keycapTextFont == rhs.keycapTextFont &&
        lhs.popupTextFont == rhs.popupTextFont &&

        lhs.drawUnder == rhs.drawUnder &&
        lhs.drawOver == rhs.drawOver &&
        lhs.drawBorder == rhs.drawBorder &&

        lhs.underOffset == rhs.underOffset &&
        lhs.popupCornerRadius == rhs.popupCornerRadius &&
        lhs.bodyCornerRadius == rhs.bodyCornerRadius &&

        lhs.popupDirection == rhs.popupDirection &&

        lhs.shouldShowPreviewPopup == rhs.shouldShowPreviewPopup &&

        lhs.shouldHighlight == rhs.shouldHighlight
}
