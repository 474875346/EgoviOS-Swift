//
//  AttendeesModel.swift
//  EgoviOS-Swift
//
//  Created by 新龙科技 on 2018/1/2.
//  Copyright © 2018年 新龙科技. All rights reserved.
//

import UIKit
import ObjectMapper
class AttendeesModel: Mappable {
    var status: Int?
    var msg:String?
    var reply:String?
     var data:Array<AttendeesReplypersons> = Array<AttendeesReplypersons>()
    required init?(map: Map) {
    }
    func mapping(map: Map) {
        status      <- map["status"]
        msg           <- map["msg"]
        reply           <- map["reply"]
        data         <- map["replyPersons"]
    }
}
class AttendeesReplypersons: Mappable {
    var post:String?
    var phone:String?
    var company:String?
    var name:String?
    required init?(map: Map) {
    }
    func mapping(map: Map) {
        post      <- map["post"]
        phone           <- map["phone"]
        company         <- map["company"]
        name      <- map["name"]
    }
}
