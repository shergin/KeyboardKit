//
//  KeyboardView.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 1/12/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import UIKit

internal final class KeyboardView: UIView {

    override static func requiresConstraintBasedLayout() -> Bool {
        return true
    }

    var touchToView: [UITouch:UIView]
    
    override init(frame: CGRect) {
        self.touchToView = [:]
        
        super.init(frame: frame)
        
        self.contentMode = UIViewContentMode.Redraw
        self.multipleTouchEnabled = true
        self.userInteractionEnabled = true
        self.opaque = false
    }

    required init?(coder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    override func intrinsicContentSize() -> CGSize {
        let interfaceOrientation = UIApplication.🚀sharedApplication().statusBarOrientation
        let isPad = UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad
        let actualScreenWidth = (UIScreen.mainScreen().nativeBounds.size.width / UIScreen.mainScreen().nativeScale)
        let canonicalPortraitHeight = (isPad ? CGFloat(264) : CGFloat(interfaceOrientation.isPortrait && actualScreenWidth >= 400 ? 226 : 216))
        let canonicalLandscapeHeight = (isPad ? CGFloat(352) : CGFloat(162))
        let canonicalHeight = interfaceOrientation.isPortrait ? canonicalPortraitHeight : canonicalLandscapeHeight
        return CGSize(width: actualScreenWidth, height: canonicalHeight)
    }

    // Why have this useless drawRect? Well, if we just set the backgroundColor to clearColor,
    // then some weird optimization happens on UIKit's side where tapping down on a transparent pixel will
    // not actually recognize the touch. Having a manual drawRect fixes this behavior, even though it doesn't
    // actually do anything.
    override func drawRect(rect: CGRect) {}

    override func hitTest(point: CGPoint, withEvent event: UIEvent!) -> UIView? {
        guard !self.hidden && self.alpha > 0 && self.userInteractionEnabled else {
            return nil
        }

        return self.bounds.contains(point) ? self : nil
    }

    func handleControl(view: UIView?, controlEvent: UIControlEvents, event: UIEvent?) {
        guard let controlView = view as? UIControl else {
            return
        }

        for target in controlView.allTargets() {
            guard let actions = controlView.actionsForTarget(target, forControlEvent: controlEvent) else {
                continue
            }

            for action in actions {
                controlView.sendAction(Selector(action), to: target, forEvent: event)
            }
        }
    }

    func findNearestView(position: CGPoint) -> UIView? {
        guard self.bounds.contains(position) else {
            return nil
        }
        
        var closest: (view: UIView, distance: CGFloat)!
        
        for view in self.subviews {
            guard !view.hidden else {
                continue
            }

            let distance = view.frame.distanceTo(position)

            if closest == nil || closest.distance > distance {
                closest = (view: view, distance: distance)
            }
        }

        guard closest != nil else {
            return nil
        }

        return closest.view
    }

    func resetTrackedViews() {
        for view in self.touchToView.values {
            self.handleControl(view, controlEvent: .TouchCancel, event: nil)
        }

        self.touchToView.removeAll(keepCapacity: true)
    }

    func ownView(newTouch: UITouch, viewToOwn: UIView?) -> Bool {
        var foundView = false

        if viewToOwn != nil {
            for (touch, view) in self.touchToView {
                if viewToOwn == view {
                    if touch == newTouch {
                        break
                    }
                    else {
                        self.touchToView[touch] = nil
                        foundView = true
                    }
                    break
                }
            }
        }

        self.touchToView[newTouch] = viewToOwn
        return foundView
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let position = touch.locationInView(self)
            let view = findNearestView(position)
            
            let viewChangedOwnership = self.ownView(touch, viewToOwn: view)
            
            if !viewChangedOwnership {
                self.handleControl(view, controlEvent: .TouchDown, event: event)
                
                if touch.tapCount > 1 {
                    // two events, I think this is the correct behavior but I have not tested with an actual UIControl
                    self.handleControl(view, controlEvent: .TouchDownRepeat, event: event)
                }
            }
        }
    }

    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let position = touch.locationInView(self)
            
            let oldView = self.touchToView[touch]
            var newView: UIView?

            if oldView != nil {
                let point = touch.locationInView(oldView!)
                let hitView = oldView!.hitTest(point, withEvent: event)

                if hitView != nil {
                    newView = oldView
                }
            }

            newView = newView ?? findNearestView(position)

            if oldView != newView {
                self.handleControl(oldView, controlEvent: .TouchDragExit, event: event)
                
                let viewChangedOwnership = self.ownView(touch, viewToOwn: newView)
                
                if !viewChangedOwnership {
                    self.handleControl(newView, controlEvent: .TouchDragEnter, event: event)
                }
                else {
                    self.handleControl(newView, controlEvent: .TouchDragInside, event: event)
                }
            }
            else {
                self.handleControl(oldView, controlEvent: .TouchDragInside, event: event)
            }
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let view = self.touchToView[touch]
            
            let touchPosition = touch.locationInView(self)
            
            if self.bounds.contains(touchPosition) {
                self.handleControl(view, controlEvent: .TouchUpInside, event: event)
            }
            else {
                self.handleControl(view, controlEvent: .TouchCancel, event: event)
            }

            self.touchToView[touch] = nil
        }
    }

    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        if let touches = touches {
            for touch in touches {
                let view = self.touchToView[touch]
                self.handleControl(view, controlEvent: .TouchCancel, event: event)
                self.touchToView[touch] = nil
            }
        }
    }

}
