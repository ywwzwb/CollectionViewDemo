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
        return self.cellCount
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SimpleCollectionViewCell
        cell.label.text = "\(indexPath.row)"
        cell.contentView.backgroundColor = self.cellBackgroundColor[indexPath.row]
        return cell
    }
}
extension FlowCollectionViewController: FlowLayoutDelegate{
    func heightFor(itemAtIndexPath indexPath: IndexPath, withWidth: CGFloat) -> CGFloat {
        return self.cellHeight[indexPath.row];
    }
}
