//
//  CGPoint+Math.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 1/18/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import UIKit

func +(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
}

func -(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
}

func *(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    return CGPoint(x: lhs.x * rhs.x, y: lhs.y * rhs.y)
}

func /(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    return CGPoint(x: lhs.x / rhs.x, y: lhs.y / rhs.y)
}



func +(lhs: CGSize, rhs: CGPoint) -> CGSize {
    return CGSize(width: lhs.width + rhs.x, height: lhs.height + rhs.y)
}

func -(lhs: CGSize, rhs: CGPoint) -> CGSize {
    return CGSize(width: lhs.width - rhs.x, height: lhs.height - rhs.y)
}

func sign(x: CGFloat) -> CGFloat {
    return x > 0 ? 1 : -1
}

extension CGPoint {

    func length() -> CGFloat {
        return hypot(self.x, self.y)
    }

    func absolute() -> CGPoint {
        return CGPoint(x: abs(self.x), y: abs(self.y))
    }

    func sign() -> CGPoint {
        return CGPoint(x: self.x >= 0 ? 1 : -1, y: self.y >= 0 ? 1 : -1)
    }
}


