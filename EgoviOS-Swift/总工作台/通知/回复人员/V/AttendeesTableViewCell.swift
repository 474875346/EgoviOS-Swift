//
//  AttendeesTableViewCell.swift
//  EgoviOS-Swift
//
//  Created by 新龙科技 on 2018/1/2.
//  Copyright © 2018年 新龙科技. All rights reserved.
//

import UIKit

class AttendeesTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var company: UILabel!
    @IBOutlet weak var post: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
