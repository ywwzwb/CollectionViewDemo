//
//  FlowCollectionViewController.swift
//  CollectionViewDemo
//
//  Created by 曾文斌 on 2017/8/21.
//  Copyright © 2017年 yww. All rights reserved.
//

import UIKit


class FlowCollectionViewController: UICollectionViewController {
    
    var cellHeight:[CGFloat]!
    var cellBackgroundColor:[UIColor]!
    let cellCount = 100
    override func viewDidLoad() {
        super.viewDidLoad()
        self.reload()
        let flowLayout = self.collectionView?.collectionViewLayout as! FlowLayout
        flowLayout.delegate = self
        
        // Do any additional setup after loading the view.
    }
    @IBAction func refreshClicked(_ sender: Any) {
        self.reload()
        self.collectionView?.reloadData()
    }
    @IBAction func appendClicked(_ sender: Any) {
        self.cellHeight.append(CGFloat(arc4random_uniform(200) + 20))
        self.cellBackgroundColor.append(UIColor.randomColor())
        self.collectionView?.insertItems(at: [IndexPath(item: self.cellHeight.count - 1, section: 0)])
    }
    @IBAction func prependClicked(_ sender: Any) {
        self.cellHeight.insert(CGFloat(arc4random_uniform(200) + 20), at: 0)
        self.cellBackgroundColor.insert(UIColor.randomColor(), at: 0)
        self.collectionView?.insertItems(at: [IndexPath(item: 0, section: 0)])
    }
    func reload() {
        self.cellHeight = {
            var heights = [CGFloat]()
            for _ in 0 ..< self.cellCount {
                heights.append(CGFloat(arc4random_uniform(200) + 20))//
            }
            return heights
        }()
        self.cellBackgroundColor = {
            var colors = [UIColor]()
            for _ in 0 ..< self.cellCount {
                colors.append(UIColor.randomColor())
            }
            return colors
        }()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
// MARK: UICollectionViewDataSource
extension FlowCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.cellHeight.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SimpleCollectionViewCell
        cell.label.text = "\(self.cellHeight[indexPath.item])"
        cell.contentView.backgroundColor = self.cellBackgroundColor[indexPath.item]
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.cellHeight.remove(at: indexPath.item)
        self.cellBackgroundColor.remove(at: indexPath.item)
        self.collectionView?.deleteItems(at: [indexPath])
    }
}
extension FlowCollectionViewController: FlowLayoutDelegate{
    func heightFor(itemAtIndexPath indexPath: IndexPath, withWidth: CGFloat) -> CGFloat {
        return self.cellHeight[indexPath.item];
    }
}
