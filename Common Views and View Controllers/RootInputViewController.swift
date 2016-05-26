//
//  RootInputViewController.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 1/27/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import UIKit


public class RootInputViewController: UIInputViewController {

    public var contentView: UIView!
    public var backgroundView: UIView!

    private var height: CGFloat? {
        didSet {
            guard oldValue != self.height else {
                return
            }

            if let value = self.height {
                self.setupKludge()

                self.heightConstraint.constant = value
                self.heightConstraint.active = true
            }
            else {
                self.heightConstraint.active = false
            }
        }
    }

    public override init(nibName: String?, bundle: NSBundle?) {
        super.init(nibName: nibName, bundle: bundle)
        log("`RootInputViewController` instance was created.")
    }

    deinit {
        log("`RootInputViewController` instance was destroyed.")
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var heightConstraint: NSLayoutConstraint = {
        assert(self.isViewLoaded(), "View must be loaded before `heightConstraint` property can be accessed.")

        let heightConstraint = NSLayoutConstraint(
            item: self.view,
            attribute: NSLayoutAttribute.Height,
            relatedBy: NSLayoutRelation.Equal,
            toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute,
            multiplier: 1.0,
            constant: 700.0
        )

        heightConstraint.priority = UILayoutPriorityDefaultHigh

        return heightConstraint
    }()

    private lazy var contentViewWidthConstraint: NSLayoutConstraint = {
        assert(self.isViewLoaded(), "View must be loaded before `contentViewWidthConstraint` property can be accessed.")

        let widthConstraint = NSLayoutConstraint(
            item: self.contentView,
            attribute: NSLayoutAttribute.Width,
            relatedBy: NSLayoutRelation.Equal,
            toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute,
            multiplier: 1.0,
            constant: 0.0
        )

        widthConstraint.active = true

        return widthConstraint
    }()

    private var kludge: UIView?
    private func setupKludge() {
        guard self.kludge == nil else {
            return
        }

        let kludge = UIView()
        kludge.translatesAutoresizingMaskIntoConstraints = false
        kludge.hidden = true
        self.view.addSubview(kludge)

        let a = NSLayoutConstraint(item: kludge, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Left, multiplier: 1, constant: 0)
        let b = NSLayoutConstraint(item: kludge, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Left, multiplier: 1, constant: 0)
        let c = NSLayoutConstraint(item: kludge, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0)
        let d = NSLayoutConstraint(item: kludge, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0)

        self.view.addConstraints([a, b, c, d])

        self.kludge = kludge
    }

    public func updateKeyboardWindowHeight() {
        self.setupKludge()

        self.view.setNeedsUpdateConstraints()
        self.view.updateConstraintsIfNeeded()

        let height = self.contentView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).height
        self.height = max(height, 100)
    }

    // # View Lifecycle

    public override func loadView() {
        super.loadView()
        // # `backgroundView`
        // It's tricky, but we have to have `backgroundView` that cover all keyboard when any animation is performing.
        let screenSize = UIScreen.mainScreen().bounds.size
        let maximumKeyboardWidthOrHeight = max(screenSize.width, screenSize.height)
        let maximumKeyboardSize = CGSize(width: maximumKeyboardWidthOrHeight, height: maximumKeyboardWidthOrHeight)
        self.backgroundView = UIView(frame: CGRect(origin: CGPointZero, size: maximumKeyboardSize))
        self.view.addSubview(self.backgroundView)

        // # `contentView`
        self.contentView = UIView()
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        self.inputView!.addSubview(self.contentView)
    }

    public override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.updateKeyboardWindowHeight()
    }

    public override func viewWillLayoutSubviews() {
        self.contentViewWidthConstraint.constant = self.view.bounds.size.width
        super.viewWillLayoutSubviews()
    }

    public override func viewDidLayoutSubviews() {
        // That's important. We manage `size` throught auto-layout, but we manage `origin` manually.
        self.contentView.frame.origin = CGPointZero
        super.viewDidLayoutSubviews()
    }

    public override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        self.updateKeyboardWindowHeight()
    }

}
