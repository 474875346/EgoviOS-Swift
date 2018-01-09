//
//  AddressBookViewModel.swift
//  EgoviOS-Swift
//
//  Created by 新龙科技 on 2018/1/8.
//  Copyright © 2018年 新龙科技. All rights reserved.
//

import UIKit
import RxSwift
import Moya_ObjectMapper
class AddressBookViewModel: NSObject {
    func getRootDept() -> Observable<AddressBookModel> {
        return HttpTool
            .rx
            .request(.getRootDept())
            .mapObject(AddressBookModel.self)
            .asObservable()
    }
    func getAllUserByDept(id:NSInteger) -> Observable<AddressGetAllUserByDeptModel> {
        return HttpTool
            .rx
            .request(.getAllUserByDept(id: id))
            .mapObject(AddressGetAllUserByDeptModel.self)
            .asObservable()
    }
    func getUserByDeptId(id:NSInteger) -> Observable<AddressGetUserByDeptIdModel> {
        return HttpTool
            .rx
            .request(.getUserByDeptId(id: id))
            .mapObject(AddressGetUserByDeptIdModel.self)
            .asObservable()
    }
    
    func getUser(id:NSInteger) -> Observable<ContactDetailsModel> {
        return HttpTool
        .rx
        .request(.getUser(id: id))
        .mapObject(ContactDetailsModel.self)
        .asObservable()
    }
}
