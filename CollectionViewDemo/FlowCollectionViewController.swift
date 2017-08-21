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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.reload()
        let flowLayout = self.collectionView?.collectionViewLayout as! FlowLayout
        flowLayout.delegate = self
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
//        self.collectionView?.register(SimpleCollectionViewCell.self, forCellWithReuseIdentifier: "cell")

        // Do any additional setup after loading the view.
    }
    @IBAction func refreshClicked(_ sender: Any) {
        self.reload()
        self.collectionView?.reloadData()
    }
    func reload() {
        self.cellHeight = {
            var heights = [CGFloat]()
            for _ in 0 ..< 100 {
                heights.append(CGFloat(arc4random_uniform(200) + 20))
            }
            return heights
        }()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 100
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SimpleCollectionViewCell
        cell.label.text = "\(indexPath.section), \(indexPath.row)"
        return cell
    }
}
extension FlowCollectionViewController: FlowLayoutDelegate{
    func heightFor(itemAtIndexPath indexPath: IndexPath, withWidth: CGFloat) -> CGFloat {
        return self.cellHeight[indexPath.row];
    }
}
