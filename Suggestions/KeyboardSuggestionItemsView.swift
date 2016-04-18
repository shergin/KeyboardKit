//
//  KeyboardSuggestionItemsView.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 2/12/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation


protocol KeyboardSuggestionItemsViewDelegate: class {
    func itemWasActivated(item: KeyboardSuggestionGuess)
}


internal final class KeyboardSuggestionItemsView: UIView {

    private var itemViews: [KeyboardSuggestionItemView] = []

    internal var appearanceManager: KeyboardAppearanceManager?

    internal var items: [KeyboardSuggestionGuess] = [] {
        didSet {
            self.updateItems()
        }
    }

    internal weak var delegate: KeyboardSuggestionItemsViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let horizontalMargin = CGFloat(4.0)
        let horizontalPadding = CGFloat(3.0)
        let verticalPadding = CGFloat(4.0)
        let compactItemWidth = self.frame.size.height - verticalPadding * 2

        let count = self.items.count
        let compactItemsCount = self.itemViews.reduce(0) { $0 + ($1.item.appearance.compact ? 1 : 0) }
        let regularItemsCount = count - compactItemsCount

        var itemFrame = self.bounds
        itemFrame.insetInPlace(dx: horizontalPadding, dy: verticalPadding)

        let width = itemFrame.size.width

        let compactItemsWidth = (compactItemWidth * CGFloat(compactItemsCount) + horizontalMargin * CGFloat(compactItemsCount)).rounded()
        let regularItemsWidth = (width - compactItemsWidth - horizontalMargin * CGFloat(regularItemsCount - 1)).rounded()
        let regularItemWidth = (regularItemsWidth / CGFloat(regularItemsCount)).rounded()

        for i in 0..<self.itemViews.count {
            itemFrame.size.width = self.itemViews[i].item.appearance.compact ? compactItemWidth : regularItemWidth

            self.itemViews[i].frame = itemFrame

            itemFrame.origin.x += itemFrame.size.width + horizontalMargin
        }
    }

    private func updateItems() {

        let addViews = {
            while self.itemViews.count < self.items.count {
                let itemView = KeyboardSuggestionItemView()
                itemView.appearanceManager = self.appearanceManager
                itemView.addTarget(self, action: "handleItemTouchDown:", forControlEvents: .TouchDown)
                self.addSubview(itemView)
                self.itemViews.append(itemView)
            }
        }

        let removeViews = {
            while self.itemViews.count > self.items.count {
                self.itemViews.last!.removeFromSuperview()
                self.itemViews.removeLast()
            }
        }

        let updateViews = {
            for i in 0..<self.items.count {
                self.itemViews[i].item = self.items[i]
            }
        }

        addViews()
        updateViews()
        removeViews()

        self.setNeedsLayout()
        //self.layoutIfNeeded()
    }
    
    dynamic func handleItemTouchDown(itemView: KeyboardSuggestionItemView) {
        self.delegate?.itemWasActivated(itemView.item)
    }

}