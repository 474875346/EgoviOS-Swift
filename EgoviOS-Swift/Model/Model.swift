//
//  Model.swift
//  TestAlamofire
//
//  Created by 田腾飞 on 2016/12/12.
//  Copyright © 2016年 田腾飞. All rights reserved.
//

import UIKit
import ObjectMapper

class Model: Mappable {
    var status: Int?
    var msg:String?
    var data:LoginData?
    var code:String?
    required init?(map: Map) {
    }
    func mapping(map: Map) {
        status      <- map["status"]
        msg           <- map["msg"]
        data         <- map["data"]
        code         <- map["code"]
    }
}
class LoginData: Mappable {
    var access_token:String?
    var dept:String?
    var duty:String?
    var realName:String?
    required init?(map: Map) {
    }
    func mapping(map: Map) {
        access_token      <- map["access_token"]
        dept           <- map["dept"]
        duty         <- map["duty"]
        realName      <- map["realName"]
    }
}
