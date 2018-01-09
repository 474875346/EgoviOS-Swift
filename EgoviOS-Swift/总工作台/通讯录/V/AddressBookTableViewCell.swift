//
//  AddressBookTableViewCell.swift
//  EgoviOS-Swift
//
//  Created by 新龙科技 on 2018/1/8.
//  Copyright © 2018年 新龙科技. All rights reserved.
//

import UIKit

class AddressBookTableViewCell: UITableViewCell {

    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var headerLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        headerLabel.backgroundColor = UIColor.randomColor
        ViewBorderRadius(view: headerLabel, Radius: 5, Width: 0, Color: UIColor.clear)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
