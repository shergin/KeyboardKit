//
//  CGRect+Hashable.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 1/12/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import UIKit


extension CGRect: Hashable {
    public var hashValue: Int {
        get {
            return (origin.x.hashValue ^ origin.y.hashValue ^ size.width.hashValue ^ size.height.hashValue)
        }
    }
}


extension CGRect {
    public func distanceTo(point: CGPoint) -> CGFloat {
        let dx = max(self.minX - point.x, point.x - self.maxX, 0)
        let dy = max(self.minY - point.y, point.y - self.maxY, 0)

        if dx * dy == 0 {
            return max(dx, dy)
        }

        return hypot(dx, dy)
    }
}
