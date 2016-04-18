//
//  KeyboardStructuredTheme.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 2/29/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation


public enum KeyboardThemeOptional<Key: Hashable, Value: Any> {
    case Identical(Value)
    case Specified([Key: Value])

    public func value(key: Key) -> Value {
        switch self {
        case .Identical(let value):
            return value
        case .Specified(let values):
            return values[key]!
        }
    }
}


public enum KeyboardKeyColorTypeOptional<T: Any> {
    case IdenticalKeyColorType(T)
    case SpecifiedKeyColorType([KeyboardKeyColorType: T])

    public func value(keyColorType: KeyboardKeyColorType) -> T {
        switch self {
        case .IdenticalKeyColorType(let value):
            return value
        case .SpecifiedKeyColorType(let values):
            return values[keyColorType] ?? values[.Special]!
        }
    }

    public func value(appearanceVariant: KeyboardKeyAppearanceVariant) -> T {
        return self.value(appearanceVariant.keyColorType)
    }
}


public enum KeyboardColorModeOptional<T: Any> {
    case IdenticalColorMode(T)
    case SpecifiedColorMode([KeyboardColorMode: T])

    public func value(colorMode: KeyboardColorMode) -> T {
        switch self {
        case .IdenticalColorMode(let value):
            return value
        case .SpecifiedColorMode(let values):
            return values[colorMode]!
        }
    }

    public func value(appearanceVariant: KeyboardKeyAppearanceVariant) -> T {
        return self.value(appearanceVariant.keyboardMode.colorMode)
    }

}


public enum KeyboardVibrancyModeOptional<T: Any> {
    case IdenticalVibrancyMode(T)
    case SpecifiedVibrancyMode([KeyboardVibrancyMode: T])

    public func value(vibrancyMode: KeyboardVibrancyMode) -> T {
        switch self {
        case .IdenticalVibrancyMode(let value):
            return value
        case .SpecifiedVibrancyMode(let values):
            return values[vibrancyMode]!
        }
    }

    public func value(appearanceVariant: KeyboardKeyAppearanceVariant) -> T {
        return self.value(appearanceVariant.keyboardMode.vibrancyMode)
    }
}


public typealias KeyboardThemeColorOptional = KeyboardKeyColorTypeOptional<KeyboardColorModeOptional<KeyboardVibrancyModeOptional<UIColor>>>
public typealias KeyboardThemePointOptional = KeyboardKeyColorTypeOptional<KeyboardColorModeOptional<KeyboardVibrancyModeOptional<CGPoint>>>
public typealias KeyboardThemeFloatOptional = KeyboardKeyColorTypeOptional<KeyboardColorModeOptional<KeyboardVibrancyModeOptional<CGFloat>>>


public protocol KeyboardStructuredTheme: KeyboardTheme {
    var keycapBodyColor: KeyboardThemeColorOptional { get }
    var keycapBorderColor: KeyboardThemeColorOptional { get }
    var keycapBorderSize: KeyboardThemeFloatOptional { get }
    var keycapTextColor: KeyboardThemeColorOptional { get }
    var keycapOuterShadowColor: KeyboardThemeColorOptional { get }
    var keycapOuterShadowOffset: KeyboardThemePointOptional { get }

    var popupBodyColor: KeyboardThemeColorOptional { get }
    var popupBorderColor: KeyboardThemeColorOptional { get }
    var popupBorderSize: KeyboardThemeFloatOptional { get }
    var popupTextColor: KeyboardThemeColorOptional { get }
    var popupOuterShadowColor: KeyboardThemeColorOptional { get }
    var popupOuterShadowOffset: KeyboardThemePointOptional { get }

    var popupHighlightedBackgroundColor: KeyboardThemeColorOptional { get }
    var popupHighlightedTextColor: KeyboardThemeColorOptional { get }
}

public extension KeyboardStructuredTheme {
    public var popupBodyColor: KeyboardThemeColorOptional { return self.keycapBodyColor }
    public var popupBorderColor: KeyboardThemeColorOptional { return self.keycapBorderColor }
    public var popupTextColor: KeyboardThemeColorOptional { return self.keycapTextColor }
    public var popupOuterShadowColor: KeyboardThemeColorOptional { return self.keycapOuterShadowColor }
    public var popupOuterShadowOffset: KeyboardThemePointOptional { return self.keycapOuterShadowOffset }
    public var popupHighlightedBackgroundColor: KeyboardThemeColorOptional { return self.popupTextColor }
    public var popupHighlightedTextColor: KeyboardThemeColorOptional { return self.popupBodyColor }
}


// # KeyboardTheme
extension KeyboardStructuredTheme {

    // # Keycap
    public func keycapBodyColorWithAppearanceVariant(appearanceVariant: KeyboardKeyAppearanceVariant) -> UIColor {
        return self.keycapBodyColor
            .value(appearanceVariant.keyColorType)
            .value(appearanceVariant.keyboardMode.colorMode)
            .value(appearanceVariant.keyboardMode.vibrancyMode)
    }

    public func keycapTextColorWithAppearanceVariant(appearanceVariant: KeyboardKeyAppearanceVariant) -> UIColor {
        return self.keycapTextColor
            .value(appearanceVariant.keyColorType)
            .value(appearanceVariant.keyboardMode.colorMode)
            .value(appearanceVariant.keyboardMode.vibrancyMode)
    }

    public func keycapBorderColorWithAppearanceVariant(appearanceVariant: KeyboardKeyAppearanceVariant) -> UIColor {
        return self.keycapBorderColor
            .value(appearanceVariant.keyColorType)
            .value(appearanceVariant.keyboardMode.colorMode)
            .value(appearanceVariant.keyboardMode.vibrancyMode)
    }

    public func keycapBorderSizeWithAppearanceVariant(appearanceVariant: KeyboardKeyAppearanceVariant) -> CGFloat {
        return self.keycapBorderSize
            .value(appearanceVariant.keyColorType)
            .value(appearanceVariant.keyboardMode.colorMode)
            .value(appearanceVariant.keyboardMode.vibrancyMode)
    }

    public func keycapOuterShadowColorWithAppearanceVariant(appearanceVariant: KeyboardKeyAppearanceVariant) -> UIColor {
        return self.keycapOuterShadowColor
            .value(appearanceVariant.keyColorType)
            .value(appearanceVariant.keyboardMode.colorMode)
            .value(appearanceVariant.keyboardMode.vibrancyMode)
    }

    // # Popup
    public func popupBodyColorWithAppearanceVariant(appearanceVariant: KeyboardKeyAppearanceVariant) -> UIColor {
        return self.popupBodyColor
            .value(appearanceVariant.keyColorType)
            .value(appearanceVariant.keyboardMode.colorMode)
            .value(appearanceVariant.keyboardMode.vibrancyMode)
    }

    public func popupTextColorWithAppearanceVariant(appearanceVariant: KeyboardKeyAppearanceVariant) -> UIColor {
        return self.popupTextColor
            .value(appearanceVariant.keyColorType)
            .value(appearanceVariant.keyboardMode.colorMode)
            .value(appearanceVariant.keyboardMode.vibrancyMode)
    }

    public func popupBorderColorWithAppearanceVariant(appearanceVariant: KeyboardKeyAppearanceVariant) -> UIColor {
        return self.popupBorderColor
            .value(appearanceVariant.keyColorType)
            .value(appearanceVariant.keyboardMode.colorMode)
            .value(appearanceVariant.keyboardMode.vibrancyMode)
    }

    public func popupBorderSizeWithAppearanceVariant(appearanceVariant: KeyboardKeyAppearanceVariant) -> CGFloat {
        return self.popupBorderSize
            .value(appearanceVariant.keyColorType)
            .value(appearanceVariant.keyboardMode.colorMode)
            .value(appearanceVariant.keyboardMode.vibrancyMode)
    }

    public func popupOuterShadowColorWithAppearanceVariant(appearanceVariant: KeyboardKeyAppearanceVariant) -> UIColor {
        return self.popupOuterShadowColor
            .value(appearanceVariant.keyColorType)
            .value(appearanceVariant.keyboardMode.colorMode)
            .value(appearanceVariant.keyboardMode.vibrancyMode)
    }

    public func popupHighlightedBackgroundColorWithAppearanceVariant(appearanceVariant: KeyboardKeyAppearanceVariant) -> UIColor {
        return self.popupHighlightedBackgroundColor
            .value(appearanceVariant.keyColorType)
            .value(appearanceVariant.keyboardMode.colorMode)
            .value(appearanceVariant.keyboardMode.vibrancyMode)
    }

    public func popupHighlightedTextColorWithAppearanceVariant(appearanceVariant: KeyboardKeyAppearanceVariant) -> UIColor {
        return self.popupHighlightedTextColor
            .value(appearanceVariant.keyColorType)
            .value(appearanceVariant.keyboardMode.colorMode)
            .value(appearanceVariant.keyboardMode.vibrancyMode)
    }
}
