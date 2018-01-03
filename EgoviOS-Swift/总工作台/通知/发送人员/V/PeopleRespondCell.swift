//
//  PeopleRespondCell.swift
//  EgoviOS-Swift
//
//  Created by 新龙科技 on 2018/1/2.
//  Copyright © 2018年 新龙科技. All rights reserved.
//

import UIKit

class PeopleRespondCell: UITableViewCell {
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var receiveTime: UILabel!
    @IBOutlet weak var userParentDpet: UILabel!
    @IBOutlet weak var userDpet: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var reply: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
