//
//  FlowLayout.swift
//  CollectionViewDemo
//
//  Created by 曾文斌 on 2017/8/21.
//  Copyright © 2017年 yww. All rights reserved.
//

import UIKit

protocol FlowLayoutDelegate: class {
    func heightFor(itemAtIndexPath indexPath: IndexPath, withWidth: CGFloat) -> CGFloat
}

class FlowLayout: UICollectionViewLayout {
    weak var delegate: FlowLayoutDelegate!
    var layoutInfo = [IndexPath : UICollectionViewLayoutAttributes]()
    let space: CGFloat = 2
    let columnsCount: CGFloat = 3
    var contentHeight: CGFloat = 0
    
    override func prepare() {
        self.layoutInfo.removeAll()
        self.contentHeight = 0
        let width = (self.collectionView!.frame.size.width - (self.columnsCount + 1) * self.space) / self.columnsCount
        var currentY: [CGFloat] = [self.space, self.space, self.space]
        for section in 0 ..< self.collectionView!.numberOfSections {
            for item in 0 ..< self.collectionView!.numberOfItems(inSection: section) {
                let indexPath = IndexPath(item: item, section: section)
                let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                var column = 0
                var minY = currentY[0]
                for i in 0 ..< currentY.count {
                    if minY > currentY[i] {
                        minY = currentY[i]
                        column = i
                    }
                }
                let x = self.space + CGFloat(column) * (self.space + width)
                let y = currentY[column]
                let height = self.delegate.heightFor(itemAtIndexPath: indexPath, withWidth: width)
                attribute.frame = CGRect(x: x, y: y, width: width, height: height)
                self.layoutInfo[indexPath] = attribute
                currentY[column] += height + self.space
                self.contentHeight = max(currentY[column], self.contentHeight)
            }
        }
    }
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attributes = [UICollectionViewLayoutAttributes]()
        for (_, attribute) in self.layoutInfo {
            if attribute.frame.intersects(rect) {
                attributes.append(attribute)
            }
        }
        return attributes
    }
    override var collectionViewContentSize: CGSize {
        return CGSize(width: self.collectionView!.frame.size.width, height: self.contentHeight)
    }
}
