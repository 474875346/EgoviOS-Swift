//
//  AddressGetAllUserByDeptModel.swift
//  EgoviOS-Swift
//
//  Created by 新龙科技 on 2018/1/9.
//  Copyright © 2018年 新龙科技. All rights reserved.
//

import UIKit
import ObjectMapper
class AddressGetAllUserByDeptModel: Mappable {
    var data = Array<AddressGetAllUserByDeptData>()
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
class AddressGetAllUserByDeptData: Mappable {
    var deptName:String?
    var userNum:String?
    var deptChild:String?
    var deptId:NSInteger?
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        deptName <- map["deptName"]
        userNum <- map["userNum"]
        deptChild <- map["deptChild"]
        deptId <- map["deptId"]
    }
}
