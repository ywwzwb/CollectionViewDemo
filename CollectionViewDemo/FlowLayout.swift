//
//  FlowLayout.swift
//  CollectionViewDemo
//
//  Created by 曾文斌 on 2017/8/21.
//  Copyright © 2017年 yww. All rights reserved.
//

import UIKit

@objc protocol FlowLayoutDelegate: class {
    func heightFor(itemAtIndexPath indexPath: IndexPath, withWidth: CGFloat) -> CGFloat
}

class FlowLayout: UICollectionViewLayout {
    @IBOutlet weak var delegate: FlowLayoutDelegate!
    var layoutInfo = [IndexPath : UICollectionViewLayoutAttributes]()
    let space: CGFloat = 2
    let colum: CGFloat = 3
    var contentHeight: CGFloat = 0
    override func prepare() {
        self.layoutInfo.removeAll()
        self.contentHeight = 0
        let width = (self.collectionView!.frame.size.width - (colum + 1) * space) / colum
        var currentY: [CGFloat] = [space, space, space]
        for section in 0 ..< self.collectionView!.numberOfSections {
            for item in 0 ..< self.collectionView!.numberOfItems(inSection: section) {
                let indexPath = IndexPath(item: item, section: section)
                let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                var colume = 0
                var minY = currentY[0]
                for i in 0 ..< currentY.count {
                    if minY > currentY[i] {
                        minY = currentY[i]
                        colume = i
                    }
                }
                let x = space + CGFloat(colume) * (space + width)
                let y = currentY[colume]
                let height = self.delegate.heightFor(itemAtIndexPath: indexPath, withWidth: width)
                attribute.frame = CGRect(x: x, y: y, width: width, height: height)
                self.layoutInfo[indexPath] = attribute
                currentY[colume] += height
                self.contentHeight = max(currentY[colume], self.contentHeight)
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
