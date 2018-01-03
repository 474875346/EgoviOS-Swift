//
//  PeopleRespondModel.swift
//  EgoviOS-Swift
//
//  Created by 新龙科技 on 2018/1/2.
//  Copyright © 2018年 新龙科技. All rights reserved.
//

import UIKit
import ObjectMapper
class PeopleRespondModel: Mappable {
    var status: Int?
    var msg:String?
    var data = Array<PeopleRespondData>()
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        status      <- map["status"]
        msg           <- map["msg"]
        data         <- map["data"]
    }
}
class PeopleRespondData: Mappable {
    var userDpet:String?
    var reply:String?
    var userParentDpet:String?
    var status:String?
    var receiveTime:String?
    var userName:String?
    required init?(map: Map) {
    }
    func mapping(map: Map) {
        userDpet      <- map["userDpet"]
        reply           <- map["reply"]
        userParentDpet         <- map["userParentDpet"]
        status      <- map["status"]
        receiveTime      <- map["receiveTime"]
        userName           <- map["userName"]
    }
}
