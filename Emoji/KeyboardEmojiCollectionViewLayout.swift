//
//  KeyboardEmojiCollectionViewLayout.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 2/18/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import UIKit


internal final class KeyboardEmojiCollectionViewLayout: UICollectionViewFlowLayout {

    override init() {
        super.init()

        self.itemSize = CGSize(width: 32.0, height: 32.0)
        self.scrollDirection = .Vertical
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareLayout() {
        super.prepareLayout()
        self.headerReferenceSize = CGSize(width: self.collectionView!.bounds.size.height, height: 32.0)
    }

    /*
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        super.shouldInvalidateLayoutForBoundsChange(newBounds)
        return true
//        self.invalidateLayoutWithContext(invalidationContextForBoundsChange(newBounds))
//        return super.shouldInvalidateLayoutForBoundsChange(newBounds)
    }

    override func invalidationContextForBoundsChange(newBounds: CGRect) -> UICollectionViewLayoutInvalidationContext {

        let context = super.invalidationContextForBoundsChange(newBounds)

        let indexPaths = (context.invalidatedSupplementaryIndexPaths ?? [:])[UICollectionElementKindSectionHeader] ?? []

        let indexPath = NSIndexPath(forItem: 0, inSection: 0)

        if !indexPaths.contains(indexPath) {
            context.invalidateSupplementaryElementsOfKind(UICollectionElementKindSectionHeader, atIndexPaths: [indexPath])
        }

        return context
    }

    override func layoutAttributesForSupplementaryViewOfKind(elementKind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        let layoutAttributes = super.layoutAttributesForSupplementaryViewOfKind(elementKind, atIndexPath: indexPath)!
        //let layoutAttributes = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: elementKind, withIndexPath: indexPath)
        let headerSize = self.headerReferenceSize
        let contentOffset = self.collectionView!.contentOffset
        layoutAttributes.frame = CGRect(origin: CGPoint(x: contentOffset.x, y: 0.0), size: headerSize)

        return layoutAttributes
    }

*/
}
