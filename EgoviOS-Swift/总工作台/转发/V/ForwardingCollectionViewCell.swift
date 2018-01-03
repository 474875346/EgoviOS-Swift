//
//  ForwardingCollectionViewCell.swift
//  EgoviOS-Swift
//
//  Created by 新龙科技 on 2017/12/27.
//  Copyright © 2017年 新龙科技. All rights reserved.
//

import UIKit

class ForwardingCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ViewBorderRadius(view: title, Radius: 20, Width: 0, Color: UIColor.clear)
    }
}
