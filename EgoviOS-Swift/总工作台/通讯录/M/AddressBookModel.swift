//
//  AddressBookModel.swift
//  EgoviOS-Swift
//
//  Created by 新龙科技 on 2018/1/8.
//  Copyright © 2018年 新龙科技. All rights reserved.
//

import UIKit
import ObjectMapper
class AddressBookModel: Mappable {
    var data = Array<AddressBookData>()
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
class AddressBookData: Mappable {
    var userNum:String?
    var name:String?
    var id:NSInteger?
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        userNum <- map["userNum"]
        name <- map["name"]
        id <- map["id"]
    }    
}
