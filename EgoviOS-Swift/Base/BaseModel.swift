//
//  BaseModel.swift
//  EgoviOS-Swift
//
//  Created by 新龙科技 on 2017/12/15.
//  Copyright © 2017年 新龙科技. All rights reserved.
//

import UIKit

class BaseModel: NSObject {
    //MARK:成功弹框
    func SuccessTost(Title:String , Body:String) -> Void {
        SwiftMessageManager.showMessage(layoutType: .MessageView, themeType: .Success, iconImageType: .light, presentationStyleType: .top, title: Title, body: Body, isHiddenBtn: true, seconds: 1)
    }
    //MARK:警告弹框
    func WaringTost(Title:String , Body:String) -> Void {
        SwiftMessageManager.showMessage(layoutType: .MessageView, themeType:.Warning, iconImageType:.light, presentationStyleType:.top, title: Title, body: Body, isHiddenBtn: true, seconds: 1)
    }
    //MARK:错误弹框
    func ErrorTost() -> Void {
        SwiftMessageManager.showMessage(layoutType: .MessageView, themeType: .Error, iconImageType: .light, presentationStyleType: .top, title: "", body: "网络问题，请休息一下", isHiddenBtn: true, seconds: 1)
    }
}
