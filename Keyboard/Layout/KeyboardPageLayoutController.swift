//
//  KeyboardPageLayoutController.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 1/13/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation

internal final class KeyboardPageLayoutController {
    private let page: KeyboardPage
    var bounds: CGRect! { didSet { self.updateBoundsRelatedThings() } }

    private let layoutConstants = LayoutConstants.self
    private var isLandscape: Bool = false

    init(page: KeyboardPage) {
        self.page = page
    }

    private func updateBoundsRelatedThings() {
        self.isLandscape = (bounds.width / bounds.height) >= self.layoutConstants.landscapeRatio

    }

    func keyFrames() -> [KeyboardKey: CGRect] {

        func characterRowHeuristic(row: [KeyboardKey]) -> Bool {
            return (row.count >= 1 && row[0].type.isCharacter)
        }

        func doubleSidedRowHeuristic(row: [KeyboardKey]) -> Bool {
            return (row.count >= 3 && !row[0].type.isCharacter && row[1].type.isCharacter)
        }

        var frames: [KeyboardKey: CGRect] = [:]

        var sideEdges = (isLandscape ? self.layoutConstants.sideEdgesLandscape : self.layoutConstants.sideEdgesPortrait(bounds.width))
        let bottomEdge = sideEdges

        let normalKeyboardSize = bounds.width - CGFloat(2) * sideEdges
        let shrunkKeyboardSize = self.layoutConstants.keyboardShrunkSize(normalKeyboardSize)

        sideEdges += ((normalKeyboardSize - shrunkKeyboardSize) / CGFloat(2))

        let topEdge: CGFloat = (isLandscape ? self.layoutConstants.topEdgeLandscape : self.layoutConstants.topEdgePortrait(bounds.width))

        let rowGap: CGFloat = (isLandscape ? self.layoutConstants.rowGapLandscape : self.layoutConstants.rowGapPortrait(bounds.width))
        let lastRowGap: CGFloat = (isLandscape ? rowGap : self.layoutConstants.rowGapPortraitLastRow(bounds.width))

        let lastRowLeftSideRatio = (isLandscape ? self.layoutConstants.lastRowLandscapeFirstTwoButtonAreaWidthToKeyboardAreaWidth : self.layoutConstants.lastRowPortraitFirstTwoButtonAreaWidthToKeyboardAreaWidth)
        let lastRowRightSideRatio = (isLandscape ? self.layoutConstants.lastRowLandscapeLastButtonAreaWidthToKeyboardAreaWidth : self.layoutConstants.lastRowPortraitLastButtonAreaWidthToKeyboardAreaWidth)
        let lastRowKeyGap = (isLandscape ? self.layoutConstants.lastRowKeyGapLandscape(bounds.width) : self.layoutConstants.lastRowKeyGapPortrait)

        let numRows = page.rows.count

        let mostKeysInRow: Int = {
            var currentMax: Int = 0
            for (_, row) in page.rows.enumerate() {
                currentMax = max(currentMax, row.count)
            }
            return currentMax
        }()

        let rowGapTotal = CGFloat(numRows - 1 - 1) * rowGap + lastRowGap

        let keyGap: CGFloat = (isLandscape ? self.layoutConstants.keyGapLandscape(bounds.width, rowCharacterCount: mostKeysInRow) : self.layoutConstants.keyGapPortrait(bounds.width, rowCharacterCount: mostKeysInRow))

        let keyHeight: CGFloat = {
            let totalGaps = bottomEdge + topEdge + rowGapTotal
            let returnHeight = (bounds.height - totalGaps) / CGFloat(numRows)
            return returnHeight.rounded()
        }()

        let letterKeyWidth: CGFloat = {
            let totalGaps = (sideEdges * CGFloat(2)) + (keyGap * CGFloat(mostKeysInRow - 1))
            let returnWidth = (bounds.width - totalGaps) / CGFloat(mostKeysInRow)
            return returnWidth.rounded()
        }()

        let processRow = { (row: [KeyboardKey], frames: [CGRect], inout map: [KeyboardKey:CGRect]) -> Void in
            assert(row.count == frames.count, "row and frames don't match")
            for (k, key) in row.enumerate() {
                map[key] = frames[k]
            }
        }

        for (r, row) in page.rows.enumerate() {
            let rowGapCurrentTotal = (r == page.rows.count - 1 ? rowGapTotal : CGFloat(r) * rowGap)

            let frame = CGRectMake(
                sideEdges,
                topEdge + (CGFloat(r) * keyHeight) + rowGapCurrentTotal,
                bounds.width - CGFloat(2) * sideEdges,
                keyHeight
            ).rounded()

            var rowFrames: [CGRect]!

            if row.isCharacterRowHeuristic() {
                // basic character row: only typable characters
                rowFrames = self.framesForCharacterRow(row, keyWidth: letterKeyWidth, gapWidth: keyGap, frame: frame)
            }
            else if row.isDoubleSidedRowHeuristic() {
                // character row with side buttons: shift, backspace, etc.
                rowFrames = self.framesForCharacterWithSidesRow(row, frame: frame, isLandscape: isLandscape, keyWidth: letterKeyWidth, keyGap: keyGap)
            }
            else {
                // bottom row with things like space, return, etc.
                rowFrames = self.framesForSpecialKeysRow(row, keyWidth: letterKeyWidth, gapWidth: lastRowKeyGap, leftSideRatio: lastRowLeftSideRatio, rightSideRatio: lastRowRightSideRatio, micButtonRatio: self.layoutConstants.micButtonPortraitWidthRatioToOtherSpecialButtons, isLandscape: isLandscape, frame: frame)
            }
            
            processRow(row, rowFrames, &frames)
        }

        return frames
    }


    private func framesForCharacterRow(row: [KeyboardKey], keyWidth: CGFloat, gapWidth: CGFloat, frame: CGRect) -> [CGRect] {
        var frames = [CGRect]()

        let keySpace = CGFloat(row.count) * keyWidth + CGFloat(row.count - 1) * gapWidth
        var actualGapWidth = gapWidth
        var sideSpace = (frame.width - keySpace) / CGFloat(2)

        // TODO: port this to the other layout functions
        // avoiding rounding errors
        if sideSpace < 0 {
            sideSpace = 0
            actualGapWidth = (frame.width - (CGFloat(row.count) * keyWidth)) / CGFloat(row.count - 1)
        }

        var currentOrigin = frame.origin.x + sideSpace

        for (_, _) in row.enumerate() {
            let roundedOrigin = currentOrigin.rounded()

            // avoiding rounding errors
            if roundedOrigin + keyWidth > frame.origin.x + frame.width {
                frames.append(CGRectMake((frame.origin.x + frame.width - keyWidth).rounded(), frame.origin.y, keyWidth, frame.height))
            }
            else {
                frames.append(CGRectMake(currentOrigin.rounded(), frame.origin.y, keyWidth, frame.height))
            }

            currentOrigin += (keyWidth + actualGapWidth)
        }

        return frames
    }

    // TODO: pass in actual widths instead
    private func framesForCharacterWithSidesRow(row: [KeyboardKey], frame: CGRect, isLandscape: Bool, keyWidth: CGFloat, keyGap: CGFloat) -> [CGRect] {
        var frames = [CGRect]()

        let standardFullKeyCount = Int(self.layoutConstants.keyCompressedThreshhold) - 1
        let standardGap = (isLandscape ? self.layoutConstants.keyGapLandscape : self.layoutConstants.keyGapPortrait)(frame.width, rowCharacterCount: standardFullKeyCount)
        let sideEdges = (isLandscape ? self.layoutConstants.sideEdgesLandscape : self.layoutConstants.sideEdgesPortrait(frame.width))
        var standardKeyWidth = (frame.width - sideEdges - (standardGap * CGFloat(standardFullKeyCount - 1)) - sideEdges)
        standardKeyWidth /= CGFloat(standardFullKeyCount)
        let standardKeyCount = self.layoutConstants.flexibleEndRowMinimumStandardCharacterWidth

        let standardWidth = CGFloat(standardKeyWidth * standardKeyCount + standardGap * (standardKeyCount - 1))
        let currentWidth = CGFloat(row.count - 2) * keyWidth + CGFloat(row.count - 3) * keyGap

        let isStandardWidth = (currentWidth < standardWidth)
        let actualWidth = (isStandardWidth ? standardWidth : currentWidth)
        let actualGap = (isStandardWidth ? standardGap : keyGap)
        let actualKeyWidth = (actualWidth - CGFloat(row.count - 3) * actualGap) / CGFloat(row.count - 2)

        let sideSpace = (frame.width - actualWidth) / CGFloat(2)

        let m = (isLandscape ? self.layoutConstants.flexibleEndRowTotalWidthToKeyWidthMLandscape : self.layoutConstants.flexibleEndRowTotalWidthToKeyWidthMPortrait)
        let c = (isLandscape ? self.layoutConstants.flexibleEndRowTotalWidthToKeyWidthCLandscape : self.layoutConstants.flexibleEndRowTotalWidthToKeyWidthCPortrait)

        var specialCharacterWidth = sideSpace * m + c
        specialCharacterWidth = max(specialCharacterWidth, keyWidth)
        specialCharacterWidth = specialCharacterWidth.rounded()
        let specialCharacterGap = sideSpace - specialCharacterWidth

        var currentOrigin = frame.origin.x
        for (k, _) in row.enumerate() {
            if k == 0 {
                frames.append(CGRectMake(currentOrigin.rounded(), frame.origin.y, specialCharacterWidth, frame.height))
                currentOrigin += (specialCharacterWidth + specialCharacterGap)
            }
            else if k == row.count - 1 {
                currentOrigin += specialCharacterGap
                frames.append(CGRectMake(currentOrigin.rounded(), frame.origin.y, specialCharacterWidth, frame.height))
                currentOrigin += specialCharacterWidth
            }
            else {
                frames.append(CGRectMake(currentOrigin.rounded(), frame.origin.y, actualKeyWidth, frame.height))
                if k == row.count - 2 {
                    currentOrigin += (actualKeyWidth)
                }
                else {
                    currentOrigin += (actualKeyWidth + keyGap)
                }
            }
        }

        return frames
    }

    private func framesForSpecialKeysRow(row: [KeyboardKey], keyWidth: CGFloat, gapWidth: CGFloat, leftSideRatio: CGFloat, rightSideRatio: CGFloat, micButtonRatio: CGFloat, isLandscape: Bool, frame: CGRect) -> [CGRect] {
        var frames = [CGRect]()

        var keysBeforeSpace = 0
        var keysAfterSpace = 0
        var reachedSpace = false
        for (_, key) in row.enumerate() {
            if key.type == .Space {
                reachedSpace = true
            }
            else {
                if !reachedSpace {
                    keysBeforeSpace += 1
                }
                else {
                    keysAfterSpace += 1
                }
            }
        }

        assert(keysBeforeSpace <= 3, "invalid number of keys before space (only max 3 currently supported)")
        assert(keysAfterSpace == 1, "invalid number of keys after space (only default 1 currently supported)")

        let hasButtonInMicButtonPosition = (keysBeforeSpace == 3)

        var leftSideAreaWidth = frame.width * leftSideRatio
        let rightSideAreaWidth = frame.width * rightSideRatio
        var leftButtonWidth = (leftSideAreaWidth - (gapWidth * CGFloat(2 - 1))) / CGFloat(2)
        leftButtonWidth = leftButtonWidth.rounded()
        var rightButtonWidth = (rightSideAreaWidth - (gapWidth * CGFloat(keysAfterSpace - 1))) / CGFloat(keysAfterSpace)
        rightButtonWidth = rightButtonWidth.rounded()

        let micButtonWidth = (isLandscape ? leftButtonWidth : leftButtonWidth * micButtonRatio)

        // special case for mic button
        if hasButtonInMicButtonPosition {
            leftSideAreaWidth = leftSideAreaWidth + gapWidth + micButtonWidth
        }

        var spaceWidth = frame.width - leftSideAreaWidth - rightSideAreaWidth - gapWidth * CGFloat(2)
        spaceWidth = spaceWidth.rounded()

        var currentOrigin = frame.origin.x
        var beforeSpace: Bool = true
        for (k, key) in row.enumerate() {
            if key.type == .Space {
                frames.append(CGRectMake(currentOrigin.rounded(), frame.origin.y, spaceWidth, frame.height))
                currentOrigin += (spaceWidth + gapWidth)
                beforeSpace = false
            }
            else if beforeSpace {
                if hasButtonInMicButtonPosition && k == 2 { //mic button position
                    frames.append(CGRectMake(currentOrigin.rounded(), frame.origin.y, micButtonWidth, frame.height))
                    currentOrigin += (micButtonWidth + gapWidth)
                }
                else {
                    frames.append(CGRectMake(currentOrigin.rounded(), frame.origin.y, leftButtonWidth, frame.height))
                    currentOrigin += (leftButtonWidth + gapWidth)
                }
            }
            else {
                frames.append(CGRectMake(currentOrigin.rounded(), frame.origin.y, rightButtonWidth, frame.height))
                currentOrigin += (rightButtonWidth + gapWidth)
            }
        }
        
        return frames
    }


}