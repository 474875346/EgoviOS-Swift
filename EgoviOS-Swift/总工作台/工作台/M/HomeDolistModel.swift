//
//  HomeDolistModel.swift
//  EgoviOS-Swift
//
//  Created by 新龙科技 on 2018/1/12.
//  Copyright © 2018年 新龙科技. All rights reserved.
//

import UIKit
import ObjectMapper
class HomeDolistModel: Mappable {
    var data:HomeDolistData?
    var msg:String?
    var status:NSInteger?
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        data <- map["data"]
        msg <- map["msg"]
        status <- map["status"]
    }
}
class HomeDolistData: Mappable {
    var mayor:String?
    var other:String?
    var welcome_return:String?
    var director:String?
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        mayor <- map["mayor"]
        other <- map["other"]
        welcome_return <- map["welcome_return"]
        director <- map["director"]
    }
}
