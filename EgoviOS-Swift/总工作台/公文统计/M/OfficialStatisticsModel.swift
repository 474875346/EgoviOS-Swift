//
//  OfficialStatisticsModel.swift
//  EgoviOS-Swift
//
//  Created by 新龙科技 on 2018/1/15.
//  Copyright © 2018年 新龙科技. All rights reserved.
//

import UIKit
import ObjectMapper
class OfficialStatisticsModel: Mappable {
    var status: Int?
    var msg:String?
    var data:Array<OfficialStatisticsData> = Array<OfficialStatisticsData>()
    var Isnumber:Bool = false
    
    required init?(map: Map) {
    }
    func mapping(map: Map) {
        status      <- map["status"]
        msg           <- map["msg"]
        data         <- map["data"]
        Isnumber    <- map["Isnumber"]
    }
}
class OfficialStatisticsData: Mappable {
    var deptName:String?
    var bumfAttachId:NSInteger?
    var time:String?
    var id:NSInteger?
    var status_color:String?
    var urgent_color:String?
    var title:String?
    var status:String?
    var type:String?
    var urgent:String?
    required init?(map: Map) {
    }
    func mapping(map: Map) {
        deptName                <- map["deptName"]
        bumfAttachId           <- map["bumfAttachId"]
        time                          <- map["time"]
        id                              <- map["id"]
        status_color                <- map["status_color"]
        urgent_color             <- map["urgent_color"]
        title                          <- map["title"]
        status                      <- map["status"]
        type                          <- map["type"]
        urgent                       <- map["urgent"]
    }
}
