//
//  KeyboardTheme.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 2/26/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation


public protocol KeyboardTheme {
    // # Keyboard
    func keyboardBackgroundColorWithAppearanceVariant(appearanceVariant: KeyboardAppearanceVariant) -> UIColor

    // # Keycap
    func keycapBodyColorWithAppearanceVariant(appearanceVariant: KeyboardKeyAppearanceVariant) -> UIColor
    func keycapTextColorWithAppearanceVariant(appearanceVariant: KeyboardKeyAppearanceVariant) -> UIColor
    func keycapBorderColorWithAppearanceVariant(appearanceVariant: KeyboardKeyAppearanceVariant) -> UIColor
    func keycapOuterShadowColorWithAppearanceVariant(appearanceVariant: KeyboardKeyAppearanceVariant) -> UIColor
    func keycapBorderSizeWithAppearanceVariant(appearanceVariant: KeyboardKeyAppearanceVariant) -> CGFloat

    // # Popup
    func popupBodyColorWithAppearanceVariant(appearanceVariant: KeyboardKeyAppearanceVariant) -> UIColor
    func popupTextColorWithAppearanceVariant(appearanceVariant: KeyboardKeyAppearanceVariant) -> UIColor
    func popupBorderColorWithAppearanceVariant(appearanceVariant: KeyboardKeyAppearanceVariant) -> UIColor
    func popupOuterShadowColorWithAppearanceVariant(appearanceVariant: KeyboardKeyAppearanceVariant) -> UIColor
    func popupBorderSizeWithAppearanceVariant(appearanceVariant: KeyboardKeyAppearanceVariant) -> CGFloat
    func popupHighlightedBackgroundColorWithAppearanceVariant(appearanceVariant: KeyboardKeyAppearanceVariant) -> UIColor
    func popupHighlightedTextColorWithAppearanceVariant(appearanceVariant: KeyboardKeyAppearanceVariant) -> UIColor
}


extension KeyboardTheme {
    public func keyboardBackgroundColorWithAppearanceVariant(appearanceVariant: KeyboardAppearanceVariant) -> UIColor {
        return UIColor.clearColor()
    }

    public func popupHighlightedBackgroundColorWithAppearanceVariant(appearanceVariant: KeyboardKeyAppearanceVariant) -> UIColor {
        return self.popupTextColorWithAppearanceVariant(appearanceVariant)
    }

    public func popupHighlightedTextColorWithAppearanceVariant(appearanceVariant: KeyboardKeyAppearanceVariant) -> UIColor {
        return self.popupBodyColorWithAppearanceVariant(appearanceVariant)
    }

}
