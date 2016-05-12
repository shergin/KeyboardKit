//
//  KeyboardStandardTheme.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 2/29/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation

// # Mess
private let bodyColor_RegularType_LightColorMode_TransparentVibrancy: UIColor = UIColor.whiteColor()
private let bodyColor_RegularType_DarkColorMode_TransparentVibrancy: UIColor = UIColor.whiteColor().colorWithAlphaComponent(CGFloat(0.3))
private let bodyColor_RegularType_LightColorMode_OpaqueVibrancy: UIColor = bodyColor_RegularType_LightColorMode_TransparentVibrancy
private let bodyColor_RegularType_DarkColorMode_OpaqueVibrancy: UIColor = UIColor(red: CGFloat(83)/CGFloat(255), green: CGFloat(83)/CGFloat(255), blue: CGFloat(83)/CGFloat(255), alpha: 1)

private let bodyColor_SpecialType_LightColorMode_TransparentVibrancy: UIColor = bodyColor_SpecialType_LightColorMode_OpaqueVibrancy
private let bodyColor_SpecialType_LightColorMode_OpaqueVibrancy: UIColor = UIColor(red: CGFloat(177)/CGFloat(255), green: CGFloat(177)/CGFloat(255), blue: CGFloat(177)/CGFloat(255), alpha: 1)
private let bodyColor_SpecialType_DarkColorMode_TransparentVibrancy: UIColor = UIColor.grayColor().colorWithAlphaComponent(CGFloat(0.3))
private let bodyColor_SpecialType_DarkColorMode_OpaqueVibrancy: UIColor = UIColor(red: CGFloat(45)/CGFloat(255), green: CGFloat(45)/CGFloat(255), blue: CGFloat(45)/CGFloat(255), alpha: 1)

private let popupColor_LightColorMode_TransparentVibrancy: UIColor = bodyColor_RegularType_LightColorMode_TransparentVibrancy
private let popupColor_LightColorMode_OpaqueVibrancy: UIColor = popupColor_LightColorMode_TransparentVibrancy
private let popupColor_DarkColorMode_TransparentVibrancy: UIColor = bodyColor_RegularType_DarkColorMode_OpaqueVibrancy//UIColor.grayColor()
private let popupColor_DarkColorMode_OpaqueVibrancy: UIColor = bodyColor_RegularType_DarkColorMode_OpaqueVibrancy

private let underColor_LightColorMode: UIColor = UIColor(hue: (220/360.0), saturation: 0.04, brightness: 0.56, alpha: 1)
private let underColor_DarkColorMode: UIColor = UIColor(red: CGFloat(38.6)/CGFloat(255), green: CGFloat(18)/CGFloat(255), blue: CGFloat(39.3)/CGFloat(255), alpha: 0.4)

private let textColor_LightColorMode: UIColor = UIColor.blackColor()
private let textColor_DarkColorMode: UIColor = UIColor.whiteColor()

private let borderColor_LightColorMode: UIColor = UIColor(hue: (214/360.0), saturation: 0.04, brightness: 0.65, alpha: 1.0)
private let borderColor_DarkColorMode: UIColor = UIColor.clearColor()


// # Something super special
private let bodyColor_SelectedState_DarkColorMode: UIColor = UIColor(red: CGFloat(214)/CGFloat(255), green: CGFloat(220)/CGFloat(255), blue: CGFloat(208)/CGFloat(255), alpha: 1)



public struct KeyboardStandardTheme: KeyboardStructuredTheme {

    public init() {}

    // # Keycap
    public var keycapBodyColor: KeyboardThemeColorOptional =
        .SpecifiedKeyColorType([
            .Regular: .SpecifiedColorMode([
                .Light: .SpecifiedVibrancyMode([
                    .Transparent: bodyColor_RegularType_LightColorMode_TransparentVibrancy,
                    .Opaque: bodyColor_RegularType_LightColorMode_OpaqueVibrancy,
                ]),
                .Dark: .SpecifiedVibrancyMode([
                    .Transparent: bodyColor_RegularType_DarkColorMode_TransparentVibrancy,
                    .Opaque: bodyColor_RegularType_DarkColorMode_OpaqueVibrancy,
                ]),
            ]),
            .Special: .SpecifiedColorMode([
                .Light: .SpecifiedVibrancyMode([
                    .Transparent: bodyColor_SpecialType_LightColorMode_TransparentVibrancy,
                    .Opaque: bodyColor_SpecialType_LightColorMode_OpaqueVibrancy,
                ]),
                .Dark: .SpecifiedVibrancyMode([
                    .Transparent: bodyColor_SpecialType_DarkColorMode_TransparentVibrancy,
                    .Opaque: bodyColor_SpecialType_DarkColorMode_OpaqueVibrancy,
                ]),
            ]),
        ])

    public var keycapTextColor: KeyboardThemeColorOptional =
        .IdenticalKeyColorType(
            .SpecifiedColorMode([
                .Light: .IdenticalVibrancyMode(textColor_LightColorMode),
                .Dark: .IdenticalVibrancyMode(textColor_DarkColorMode),
            ])
        )

    public var keycapBorderColor: KeyboardThemeColorOptional =
        .IdenticalKeyColorType(
            .IdenticalColorMode(
                .IdenticalVibrancyMode(UIColor.clearColor())
            )
        )

    public var keycapBorderSize: KeyboardThemeFloatOptional =
        .IdenticalKeyColorType(
            .IdenticalColorMode(
                .IdenticalVibrancyMode(CGFloat(0))
            )
        )

    public var keycapOuterShadowColor: KeyboardThemeColorOptional =
        .IdenticalKeyColorType(
            .SpecifiedColorMode([
                .Light: .IdenticalVibrancyMode(underColor_LightColorMode),
                .Dark: .IdenticalVibrancyMode(underColor_DarkColorMode),
            ])
        )

    public var keycapOuterShadowOffset: KeyboardThemePointOptional =
        .IdenticalKeyColorType(
            .IdenticalColorMode(
                .IdenticalVibrancyMode(CGPoint(x: 0, y: 6))
            )
        )

    // # Popup

    public var popupBodyColor: KeyboardThemeColorOptional =
        .IdenticalKeyColorType(
            .SpecifiedColorMode([
                .Light: .SpecifiedVibrancyMode([
                    .Transparent: popupColor_LightColorMode_TransparentVibrancy,
                    .Opaque: popupColor_LightColorMode_OpaqueVibrancy,
                ]),
                .Dark: .SpecifiedVibrancyMode([
                    .Transparent: popupColor_DarkColorMode_TransparentVibrancy,
                    .Opaque: popupColor_DarkColorMode_OpaqueVibrancy,
                ]),
            ])
        )

    public var popupBorderColor: KeyboardThemeColorOptional =
        .IdenticalKeyColorType(
            .SpecifiedColorMode([
                .Light: .IdenticalVibrancyMode(borderColor_LightColorMode),
                .Dark: .IdenticalVibrancyMode(borderColor_DarkColorMode),
            ])
        )

    public var popupBorderSize: KeyboardThemeFloatOptional =
        .IdenticalKeyColorType(
            .IdenticalColorMode(
                .IdenticalVibrancyMode(CGFloat(0.5))
            )
        )

    // Custom hooks

    public func keycapBodyColorWithAppearanceVariant(appearanceVariant: KeyboardKeyAppearanceVariant) -> UIColor {
        // Idea: Selected Shift key in dark color mode looks differently.
        if
            appearanceVariant.keyMode.selectionMode == .Selected &&
            appearanceVariant.keyType == .Shift &&
            appearanceVariant.keyboardMode.colorMode == .Dark
        {
            return bodyColor_SelectedState_DarkColorMode
        }

        var keyColorType = appearanceVariant.keyColorType

        // Idea: Selected special keys looks like regular keys
        if
            keyColorType == .Special &&
            appearanceVariant.keyMode.selectionMode == .Selected
        {
            keyColorType = .Regular
        }

        // Idea:
        if
            appearanceVariant.keyMode.popupMode == .None &&
            appearanceVariant.keyMode.highlightMode == .Highlighted
        {
            keyColorType = keyColorType == .Regular ? .Special : .Regular
        }

        return self.keycapBodyColor
            .value(keyColorType)
            .value(appearanceVariant)
            .value(appearanceVariant)
    }

}

