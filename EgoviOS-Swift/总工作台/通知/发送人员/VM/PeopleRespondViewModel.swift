//
//  PeopleRespondViewModel.swift
//  EgoviOS-Swift
//
//  Created by 新龙科技 on 2018/1/2.
//  Copyright © 2018年 新龙科技. All rights reserved.
//

import UIKit
import RxSwift
class PeopleRespondViewModel: NSObject {
    func viewDown(id:NSInteger) -> Observable<PeopleRespondModel> {
        return HttpTool
        .rx
        .request(.viewDown(id: id))
        .mapObject(PeopleRespondModel.self)
        .asObservable()
    }
}
