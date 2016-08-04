//
//  KeyboardNumericKeypadViewController.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 8/3/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import UIKit

public class KeyboardNumericKeypadViewController: UIViewController {

    private var keysView: KeyboardNumericKeysView!
    public var appearanceManager: KeyboardAppearanceManager = defaultAppearanceManager {
        didSet {
            self.updateAppearance()
        }
    }

    public init() {
        super.init(nibName: nil, bundle: nil)

        KeyboardTextDocumentCoordinator.sharedInstance.addObserver(self)
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func loadView() {
        super.loadView()

        self.keysView = KeyboardNumericKeysView()
        self.view.addSubview(self.keysView)

        self.updateAppearance()
    }

    public override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        let ratio = CGFloat(2)

        let bounds = self.view.bounds

        var keysFrame = bounds

        if keysFrame.size.width / keysFrame.size.height > ratio {
            keysFrame.size.width = (keysFrame.size.height * ratio).rounded()
            keysFrame.origin.x = ((bounds.width - keysFrame.size.width) / 2).rounded()
        }

        self.keysView.frame = keysFrame
    }

    private func updateAppearance() {
        guard self.isViewLoaded() else {
            return
        }

        self.keysView.appearanceManager = self.appearanceManager
    }

}


extension KeyboardNumericKeypadViewController: KeyboardTextDocumentObserver {
    public func keyboardTextInputTraitsDidChange(textInputTraits: UITextInputTraits) {
        self.updateAppearance()
    }
}
