//
//  UIColor+Random.swift
//  CollectionViewDemo
//
//  Created by 曾文斌 on 2017/8/21.
//  Copyright © 2017年 yww. All rights reserved.
//

import UIKit

extension UIColor {
    static func randomColor() -> UIColor {
        let r = Float(arc4random_uniform(256)) / Float(256)
        let g = Float(arc4random_uniform(256)) / Float(256)
        let b = Float(arc4random_uniform(256)) / Float(256)
        return UIColor(colorLiteralRed: r, green: g, blue: b, alpha: 1)
    }
}
