//
//  ContactDetailsModel.swift
//  EgoviOS-Swift
//
//  Created by 新龙科技 on 2018/1/9.
//  Copyright © 2018年 新龙科技. All rights reserved.
//

import UIKit
import ObjectMapper
class ContactDetailsModel: Mappable {
    var data:ContactDetailsData?
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
class ContactDetailsData: Mappable {
    var maxName:String?
    var phone:String?
    var realName:String?
    var parentName:String?
    var deptName:String?
    var imageUrl:String?
    var telephone:String?
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        maxName <- map["maxName"]
        phone <- map["phone"]
        realName <- map["realName"]
        parentName <- map["parentName"]
        deptName <- map["deptName"]
        imageUrl <- map["imageUrl"]
        telephone <- map["telephone"]
    }
}
