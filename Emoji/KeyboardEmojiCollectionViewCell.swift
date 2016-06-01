//
//  KeyboardEmojiCollectionViewCell.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 2/18/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation


internal final class KeyboardEmojiCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "KeyboardEmojiCollectionViewCell"

    var labelView: UILabel!

    var emoji: KeyboardEmoji! {
        didSet {
            if oldValue != self.emoji {
                self.updateEmoji()
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.labelView = UILabel()
        self.labelView.frame = self.contentView.bounds
        self.labelView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        self.labelView.textAlignment = .Center
        self.labelView.font = UIFont.systemFontOfSize(28.0)
        self.contentView.addSubview(labelView)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func updateEmoji() {
        self.labelView.text = self.emoji.character
    }

    override var highlighted: Bool {
        didSet {
            self.labelView.alpha = self.highlighted ? 0.6 : 1.0
        }
    }

}
