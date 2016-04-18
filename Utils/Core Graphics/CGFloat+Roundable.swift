//
//  CGFloat+Roundable.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 1/13/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import UIKit

private let mainScreenScale = UIScreen.mainScreen().scale

protocol Roundable {
    func rounded() -> Self
}

extension CGFloat: Roundable {
    func rounded() -> CGFloat {
        return round(self * mainScreenScale) / mainScreenScale
    }
}

extension CGRect: Roundable {
    func rounded() -> CGRect {
        return CGRect(origin: self.origin.rounded(), size: self.size.rounded())
    }
}

extension CGSize: Roundable {
    func rounded() -> CGSize {
        return CGSize(width: self.width.rounded(), height: self.height.rounded())
    }
}

extension CGPoint: Roundable {
    func rounded() -> CGPoint {
        return CGPoint(x: self.x.rounded(), y: self.y.rounded())
    }
}
