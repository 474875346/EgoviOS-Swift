//
//  ForwardingTableViewCell.swift
//  EgoviOS-Swift
//
//  Created by 新龙科技 on 2017/12/27.
//  Copyright © 2017年 新龙科技. All rights reserved.
//

import UIKit

class ForwardingTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var RadioSwitch: UISwitch!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
