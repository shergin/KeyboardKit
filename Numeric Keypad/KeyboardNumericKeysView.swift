//
//  KeyboardNumericKeysView.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 8/3/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import UIKit


internal class KeyboardNumericKeysView: UIView {
    private var keyViews: [KeyboardNumericKeyView] = []

    internal var appearanceManager: KeyboardAppearanceManager = defaultAppearanceManager {
        didSet {
            self.updateAppearance()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        let keyTypes: [KeyboardNumericKeyType] = [
            .Number(number: 1, letters: "   "),
            .Number(number: 2, letters: "ABC"),
            .Number(number: 3, letters: "DEF"),
            .Number(number: 4, letters: "GHI"),
            .Number(number: 5, letters: "JKL"),
            .Number(number: 6, letters: "MNO"),
            .Number(number: 7, letters: "PQRS"),
            .Number(number: 8, letters: "TUV"),
            .Number(number: 9, letters: "WXYZ"),
            .Nothing,
            .Number(number: 0, letters: ""),
            .Backspace,
        ]

        for keyType in keyTypes {
            let keyView = KeyboardNumericKeyView()
            keyView.keyType = keyType
            keyView.addTarget(self, action: #selector(self.handleKey(_:)), forControlEvents: .TouchUpInside)
            self.addSubview(keyView)
            self.keyViews.append(keyView)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let cols = 3
        let rows = 4
        let bounds = self.bounds

        let horizontalMargin = CGFloat(1)
        let verticalMargin = CGFloat(1)

        let keySize = CGSize(
            width: ((bounds.width - horizontalMargin * CGFloat(cols - 1)) / CGFloat(cols)).rounded(),
            height: ((bounds.height - verticalMargin * CGFloat(rows - 1)) / CGFloat(rows)).rounded()
        )

        for i in 0..<keyViews.count {
            let row = i / cols
            let col = i % cols

            let keyOrigin = CGPoint(
                x: CGFloat(col) * keySize.width + CGFloat(col) * verticalMargin,
                y: CGFloat(row) * keySize.height + CGFloat(row) * horizontalMargin
            )

            keyViews[i].frame = CGRect(origin: keyOrigin, size: keySize)
        }
    }

    public dynamic func handleKey(keyView: KeyboardNumericKeyView) {
        guard let textDocumentProxy = UIInputViewController.optionalRootInputViewController?.textDocumentProxy else {
            return
        }

        KeyboardSoundService.sharedInstance.playInputSound()

        switch keyView.keyType {
        case .Number(let number, let _):
            textDocumentProxy.insertText(String(number))
            break
        case .Backspace:
            textDocumentProxy.deleteBackward()
            break
        case .Nothing:
            break
        }
    }

    private func updateAppearance() {
        for keyView in self.keyViews {
            keyView.appearanceManager = self.appearanceManager
        }
    }
}
