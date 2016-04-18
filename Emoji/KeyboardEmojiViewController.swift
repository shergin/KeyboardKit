//
//  KeyboardEmojiViewController.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 2/18/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import UIKit


public class KeyboardEmojiViewController: UICollectionViewController {

    var emojis = KeyboardEmojis.sharedInstance

    public init() {
        let layout = KeyboardEmojiCollectionViewLayout()
        super.init(collectionViewLayout: layout)
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func loadView() {
        super.loadView()

        self.collectionView!.registerClass(KeyboardEmojiCollectionViewCell.self, forCellWithReuseIdentifier: KeyboardEmojiCollectionViewCell.reuseIdentifier)
        self.collectionView!.registerClass(KeyboardEmojiCollectionSectionHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: KeyboardEmojiCollectionSectionHeaderView.reuseIdentifier)
        self.collectionView!.dataSource = self
        self.collectionView!.delegate = self

        self.collectionView!.backgroundColor = UIColor.clearColor()
        self.collectionView!.backgroundView?.backgroundColor = UIColor.clearColor()
    }
}


extension KeyboardEmojiViewController /*: UICollectionViewDataSource */ {

    public override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let category = self.emojis.categories[section]
        return self.emojis.emojisByCategory[category]!.count
    }

    public override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let category = self.emojis.categories[indexPath.section]
        let index = indexPath.row

        let cell = self.collectionView?.dequeueReusableCellWithReuseIdentifier(KeyboardEmojiCollectionViewCell.reuseIdentifier, forIndexPath: indexPath) as! KeyboardEmojiCollectionViewCell
        let emoji = self.emojis.emojisByCategory[category]![index]
        cell.emoji = emoji
        return cell
    }

    public override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return self.emojis.categories.count
    }

    public override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let category = self.emojis.categories[indexPath.section]
        let index = indexPath.row

        let headerView = self.collectionView?.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: KeyboardEmojiCollectionSectionHeaderView.reuseIdentifier, forIndexPath: indexPath) as! KeyboardEmojiCollectionSectionHeaderView
        headerView.emojiCategory = category
        return headerView
    }

}


extension KeyboardEmojiViewController /*: UICollectionViewDelegate */ {

    public override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let category = self.emojis.categories[indexPath.section]
        let index = indexPath.row
        let emoji = self.emojis.emojisByCategory[category]![index]

        UIInputViewController.rootInputViewController.textDocumentProxy.insertText(emoji.character)
    }

}