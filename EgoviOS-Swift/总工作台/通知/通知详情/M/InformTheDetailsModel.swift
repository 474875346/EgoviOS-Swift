//
//  InformTheDetailsModel.swift
//  EgoviOS-Swift
//
//  Created by 新龙科技 on 2017/12/19.
//  Copyright © 2017年 新龙科技. All rights reserved.
//

import UIKit

import ObjectMapper
class InformTheDetailsModel: Mappable {
    var status: Int?
    var msg:String?
    var data:InformTheDetailsData?
    required init?(map: Map) {
    }
    func mapping(map: Map) {
        status      <- map["status"]
        msg           <- map["msg"]
        data         <- map["data"]
    }
}
class InformTheDetailsData: Mappable {
    var summary:String?
    var sendTime:String?
    var datas : Array<InformTheDetailsDatas>?
    var title:String?
    var status_english:String?
    var articleDetailSize:Int?
    var status:String?
    required init?(map: Map) {
    }
    func mapping(map: Map) {
        summary      <- map["summary"]
        sendTime           <- map["sendTime"]
        datas         <- map["datas"]
        title         <- map["title"]
        status_english         <- map["status_english"]
        articleDetailSize         <- map["articleDetailSize"]
        status         <- map["status"]
    }
}
class InformTheDetailsDatas: Mappable {
    var name:String?
    var attachId:String?
    var attachName:String?
    var id:NSInteger?
    required init?(map: Map) {
    }
    func mapping(map: Map) {
        name      <- map["name"]
        attachId           <- map["attachId"]
        attachName         <- map["attachName"]
        id      <- map["id"]
    }
}
