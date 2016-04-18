//
//  RootInputViewController.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 1/27/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import UIKit


public class RootInputViewController: UIInputViewController {

    @available(*, deprecated, message="Use `UIInputViewController.rootInputViewController` instead.")
    public static var sharedInstance: RootInputViewController!

    public var contentView: KeyboardContentView!
    public var backgroundView: UIView!

    public var height: CGFloat? {
        didSet {
            guard oldValue != self.height else {
                return
            }

            if let value = self.height {
                self.setupKludge()

                self.heightConstraint.constant = value
                self.heightConstraint.active = true
                //self.view.setNeedsLayout()
                //self.view.layoutIfNeeded()
            }
            else {
                self.heightConstraint.active = false
            }
        }
    }

    public override init(nibName: String?, bundle: NSBundle?) {
        super.init(nibName: nibName, bundle: bundle)
        self.dynamicType.sharedInstance = self
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

//    private lazy var contentViewHeightConstraint: NSLayoutConstraint = {
//        assert(self.isViewLoaded(), "View must be loaded before `contentViewWidthConstraint` property can be accessed.")
//
//        let heightConstraint = NSLayoutConstraint(
//            item: self.contentView,
//            attribute: NSLayoutAttribute.Height,
//            relatedBy: NSLayoutRelation.GreaterThanOrEqual,
//            toItem: nil,
//            attribute: NSLayoutAttribute.NotAnAttribute,
//            multiplier: 1.0,
//            constant: 0.0
//        )
//
//        heightConstraint.active = true
//
//        return heightConstraint
//    }()


    var kludge: UIView?
    func setupKludge() {
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


    private func updateKeyboardWindowHeight() {
        print("updateKeyboardWindowHeight")

        self.setupKludge()

//        self.contentView.subviews.first!.frame = CGRect(origin: CGPointZero, size: UILayoutFittingExpandedSize)
//        self.contentView.subviews.first!.setNeedsLayout()

        self.contentView.setNeedsUpdateConstraints()
        let height = self.contentView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).height
        /*
        //self.contentView.constraints.map { print($0) }
        let oldSize = self.contentView.frame.size
        self.contentView.frame.size = UILayoutFittingExpandedSize
        //let height = self.contentView.systemLayoutSizeFittingSize(UILayoutFittingExpandedSize, withHorizontalFittingPriority: UILayoutPriorityRequired, verticalFittingPriority: UILayoutPriorityRequired).height
        let height = self.contentView.systemLayoutSizeFittingSize(UILayoutFittingExpandedSize).height
        self.contentView.frame.size = oldSize
*/

        self.height = max(height, 100)
    }

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
        self.contentView = KeyboardContentView()
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        self.inputView!.addSubview(self.contentView)
    }

    public override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.updateKeyboardWindowHeight()
    }

    public override func viewWillLayoutSubviews() {
        self.contentViewWidthConstraint.constant = self.view.bounds.size.width
//
//        print("width = \(self.view.bounds.size.width)")
//
        super.viewWillLayoutSubviews()
    }

    public override func viewDidLayoutSubviews() {
        self.contentView.frame.origin = CGPointZero
//        let bounds = self.view.bounds
//
//        guard bounds.width != 0 && bounds.height != 0 else {
//            return
//        }

        //self.setupKludge()

        super.viewDidLayoutSubviews()
    }


    public override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        print("*** viewWillTransitionToSize:\(size)");
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)

//        let width = UIScreen.mainScreen().bounds.size.width
//        let height = UIScreen.mainScreen().bounds.size.height
//        self.view.window!.frame = CGRect(x: 0, y: 0, width: width, height: height)









//        self.contentView.setNeedsUpdateConstraints()
//        self.contentView.updateConstraintsIfNeeded()
//
//        self.contentView.setNeedsLayout()
//        self.contentView.layoutIfNeeded()

        self.updateKeyboardWindowHeight()
    }


//    public override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
//        print("*** viewWillTransitionToSize:\(size)");
//        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
//
//        let width = UIScreen.mainScreen().bounds.size.width
//        let height = UIScreen.mainScreen().bounds.size.height
//        self.view.window!.frame = CGRect(x: 0, y: 0, width: width, height: height)
//    }

















//    public override func viewWillLayoutSubviews() {
//        print("*** viewWillLayoutSubviews():\(self.view.bounds)");
//        print("***  self.contentView.frame:\(self.contentView.frame)");
//
//        super.viewWillLayoutSubviews()
//        let bounds = self.view.bounds
//
//        guard bounds.width != 0 && bounds.height != 0 else {
//            return
//        }
//
//        self.contentView.frame = bounds
//
///*
//        //assert(self.inputView!.subviews.count == 1 && self.inputView!.subviews.first == self.contentView, "A `inputView` must contain only a `containerView`.")
//
//        //let frame = self.view.bounds
//
//            //self.contentView.frame
//        var bounds = self.view.bounds
//        let height = self.contentView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).height
//        print("height: \(height)")
//        print("bounds: \(bounds)")
//
////        bounds.size.height = height
////        self.contentView.frame = bounds
//
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(0.1 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) { () -> Void in
//            print("applied height: \(height)")
//            self.height = height
//        }
//*/
//        /*
//        guard self.mainViewController is KeyboardWithoutFullAccessViewController else {
//            return
//        }
//
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(0.1 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) { () -> Void in
//            let height = self.mainViewController.view.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).height
//            self.height = height
//        }
//        */
//    }
///*
//    public override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//
////        self.contentView.frame = self.view.bounds
////        self.contentView.setNeedsLayout()
////        self.contentView.layoutIfNeeded()
//    }
//*/
}
