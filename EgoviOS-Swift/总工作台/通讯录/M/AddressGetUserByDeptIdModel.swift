//
//  AddressGetUserByDeptIdModel.swift
//  EgoviOS-Swift
//
//  Created by 新龙科技 on 2018/1/9.
//  Copyright © 2018年 新龙科技. All rights reserved.
//

import UIKit
import ObjectMapper
class AddressGetUserByDeptIdModel: Mappable {
    var data = Array<AddressGetUserByDeptIdData>()
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
class AddressGetUserByDeptIdData: Mappable {
    var email:String?
    var phone:String?
    var realName:String?
    var id:NSInteger?
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        email <- map["email"]
        phone <- map["phone"]
        realName <- map["realName"]
        id <- map["id"]
    }
}
