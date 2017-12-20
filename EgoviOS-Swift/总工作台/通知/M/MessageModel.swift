//
//  MessageModel.swift
//  EgoviOS-Swift
//
//  Created by 新龙科技 on 2017/12/15.
//  Copyright © 2017年 新龙科技. All rights reserved.
//

import UIKit
import ObjectMapper
class MessageModel: Mappable {
    var status: Int?
    var msg:String?
    var data:Array<MessageData>?
    var code:String?
    var Isnumber:Bool?
    
    required init?(map: Map) {
    }
    func mapping(map: Map) {
        status      <- map["status"]
        msg           <- map["msg"]
        data         <- map["data"]
        code         <- map["code"]
        Isnumber    <- map["Isnumber"]
    }
}
class MessageData: Mappable {
    var summary:String?
    var category:String?
    var time:String?
    var id:NSInteger?
    var statuColor:String?
    var sendUser:String?
    var title:String?
    var status:String?
    required init?(map: Map) {
    }
    func mapping(map: Map) {
        summary      <- map["summary"]
        category           <- map["category"]
        time         <- map["time"]
        id      <- map["id"]
        statuColor      <- map["statuColor"]
        sendUser           <- map["sendUser"]
        title         <- map["title"]
        status      <- map["status"]
    }
}


