//
//  ViewModel.swift
//  TestAlamofire
//
//  Created by 田腾飞 on 2016/12/12.
//  Copyright © 2016年 田腾飞. All rights reserved.
//

import UIKit
import RxSwift
import Moya_ObjectMapper
class ViewModel: NSObject {
    func initLogin(name:String,psw:String) -> Observable<Model> {
        return HttpTool
            .rx
            .request(.LogIn(Name: name, Psw: psw))
            .filter(statusCodes: 200...500)
            .mapObject(Model.self)
            .asObservable()
    }
}
