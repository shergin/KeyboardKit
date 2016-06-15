//
//  KeyboardViewController.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 1/13/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import UIKit


public class KeyboardViewController: UIViewController {
    // # Private
    private let keyViewPool = KeyboardKeyViewPool()
    private var pageLayoutControllers: [KeyboardPageLayoutController] = []
    private var lastLayoutBounds = CGSizeZero

    public let shiftStatusController = KeyboardShiftStatusController()

    // # Internal
    internal let keyViewSet = KeyboardKeyViewSet()
    internal var keyboardView: KeyboardView { return self.view as! KeyboardView }

    // # Public
    public var keyboardLayout: KeyboardLayout {
        didSet {
            self.initializePageLayoutControllers()
            self.establishKeyViews(pageNumber: self.pageNumber)
            self.layoutKeyViews()
        }
    }

    public var appearanceManager: KeyboardAppearanceManager
    public var pageNumber: Int = 0 {
        didSet {
            if oldValue != self.pageNumber {
                self.establishKeyViews(pageNumber: self.pageNumber)
            }
        }
    }

    public var keyboardMode: KeyboardMode { didSet { self.keyboardModeDidSet(oldValue) } }
    public private(set) var listenerCoordinator: KeyboardKeyListenerCoordinator!

    public init(keyboardLayout: KeyboardLayout) {
        self.keyboardLayout = keyboardLayout
        self.keyboardMode = KeyboardMode(inputViewController: UIInputViewController.rootInputViewController)
        self.appearanceManager = KeyboardAppearanceManager()

        super.init(nibName: nil, bundle: nil)

        self.shiftStatusController.keyboardViewController = self

        self.initializePageLayoutControllers()

        KeyboardTextDocumentCoordinator.sharedInstance.addObserver(self)

        self.listenerCoordinator = KeyboardKeyListenerCoordinator(keyboardViewController: self)

        self.listenerCoordinator.addListener(KeyboardSoundController())
        self.listenerCoordinator.addListener(KeyboardCharacterKeyListener())
        self.listenerCoordinator.addListener(KeyboardCommonActionKeyListener())
        self.listenerCoordinator.addListener(KeyboardBackspaceKeyController())
        self.listenerCoordinator.addListener(KeyboardKeyPopupTypeController())
        self.listenerCoordinator.addListener(KeyboardKeyHighlightController())
        self.listenerCoordinator.addListener(KeyboardPagesController())
        self.listenerCoordinator.addListener(KeyboardShiftController())
        self.listenerCoordinator.addListener(KeyboardPeriodShortcutController())

        precondition(!self.isViewLoaded(), "Keyboard's view must not be loaded after `init()`.")
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        self.listenerCoordinator.unregistedKeyViews()
    }

    // # View life-cycle

    public override func loadView() {
        self.view = KeyboardView()
    }

    public override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        self.view.invalidateIntrinsicContentSize()
        self.establishKeyViews(pageNumber: self.pageNumber)
    }

    public override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        KeyboardRegistry.sharedInstance.registerKeyboardViewController(self)
    }

    public override func viewWillDisappear(animated: Bool) {
        KeyboardRegistry.sharedInstance.unregisterKeyboardViewController(self)
        super.viewWillDisappear(animated)
    }

    public override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        guard self.view.bounds != CGRectZero else {
            return
        }

        //for view in self.keyViewSet.views { view.shouldRasterize = true }

        self.layoutKeyViewsIfNeeded()
    }


    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        guard self.view.bounds != CGRectZero else {
            return
        }

        //for view in self.keyViewSet.views { view.shouldRasterize = false }
    }

    public override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        self.view.invalidateIntrinsicContentSize()
        self.view.setNeedsUpdateConstraints()
        self.view.setNeedsLayout()
    }

    // # Private

    private func establishKeyViews(pageNumber pageNumber: Int) {
        CATransaction.begin()
        CATransaction.setDisableActions(true)

        self.establishKeyViews(
            page: self.keyboardLayout.pages[pageNumber],
            pageLayoutController: self.pageLayoutControllers[pageNumber]
        )

        CATransaction.commit()
    }

    private func initializePageLayoutControllers() {
        self.pageLayoutControllers = self.keyboardLayout.pages.map {
            KeyboardPageLayoutController(page: $0)
        }
    }

    private func establishKeyViews(page page: KeyboardPage, pageLayoutController: KeyboardPageLayoutController) {
        // Setup `KeyboardPageLayoutController`.
        pageLayoutController.bounds = self.view.bounds

        // Return all object from a set to a pool and then clean the set.
        self.keyViewPool.storeSet(self.keyViewSet)
        self.keyViewSet.removeAll()

        let keyFrames = pageLayoutController.keyFrames()

        for (key, frame) in keyFrames {
            let keyView = self.retrieveKeyViewUsingPool(key: key, frame: frame)

            self.keyViewSet.insert(key, keyView: keyView)
        }

        // Apply `hidden` property.
        for view in self.keyViewPool.keyViews { view.hidden = true }
        for view in self.keyViewSet.views { view.hidden = false }

        self.updateKeyViewsIfNeeded()

        self.keyboardView.resetTrackedViews()
        self.listenerCoordinator.registerKeyViews()
    }

    private func layoutKeyViewsIfNeeded() {
        let pageLayoutController = self.pageLayoutControllers[self.pageNumber]

        if pageLayoutController.bounds == self.view.bounds {
            return
        }

        self.layoutKeyViews()
    }

    private func layoutKeyViews() {
        CATransaction.begin()
        CATransaction.setDisableActions(true)

        let pageLayoutController = self.pageLayoutControllers[self.pageNumber]
        pageLayoutController.bounds = self.view.bounds

        let keyFrames = pageLayoutController.keyFrames()

        for (key, frame) in keyFrames {
            let keyView = self.keyViewSet.viewByKey(key)!
            keyView.frame = frame
        }

        CATransaction.commit()
    }

    private func retrieveKeyViewUsingPool(key key: KeyboardKey, frame: CGRect) -> KeyboardKeyView {
        if let keyView = self.keyViewPool.restore(size: frame.size, keyType: key.type) {
            keyView.prepareForReuse()
            keyView.frame.origin = frame.origin
            return keyView
        }

        let keyView = self.createAndRegisterKeyView(key: key)
        keyView.frame = frame
        return keyView
    }

    private func createAndRegisterKeyView(key key: KeyboardKey) -> KeyboardKeyView {
        let keyView = KeyboardKeyView()
        keyView.appearanceManager = self.appearanceManager
        self.view.addSubview(keyView)
        return keyView
    }

    internal func updateKeyViewsIfNeeded() {
        CATransaction.begin()
        CATransaction.setDisableActions(true)

        self.updateKeyboardAppearance()

        for (key, keyView) in self.keyViewSet {
            keyView.key = key
            keyView.keyboardMode = self.keyboardMode
            keyView.updateIfNeeded()
        }

        CATransaction.commit()
    }

    func keyboardModeDidSet(oldValue: KeyboardMode) {
        guard self.keyboardMode != oldValue else {
            return
        }

        self.updateKeyViewsIfNeeded()
    }

    private func updateKeyboardColorMode() {
        self.keyboardMode.colorMode = KeyboardColorMode.suitable()
    }

    private func updateKeyboardAppearance() {
        var appearanceVariant = KeyboardAppearanceVariant()
        appearanceVariant.colorMode = self.keyboardMode.colorMode

        let backgorundColor = self.appearanceManager.theme.keyboardBackgroundColorWithAppearanceVariant(appearanceVariant)
        if let rootInputViewController = UIInputViewController.rootInputViewController as? RootInputViewController {
            rootInputViewController.backgroundView.backgroundColor = backgorundColor
        }
        else {
            self.keyboardView.backgroundColor = backgorundColor
        }
    }

}

extension KeyboardViewController: KeyboardTextDocumentObserver {
    public func keyboardTextInputTraitsDidChange(textInputTraits: UITextInputTraits) {
        self.updateKeyboardColorMode()
    }
}
