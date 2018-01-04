//
//  WorktableViewViewModel.swift
//  EgoviOS-Swift
//
//  Created by 新龙科技 on 2018/1/3.
//  Copyright © 2018年 新龙科技. All rights reserved.
//

import UIKit
import RxSwift
class WorktableViewViewModel: NSObject {
    let sections = Variable<[LXFSection]>([])
    func MainpageConversion(_ modelArray:[[LXFModel]]) -> Void {
        let section =  modelArray.map { model in
            return LXFSection(items: model)
        }
        sections.value = section
    }
    func LoginOut() -> Observable<Model> {
        return HttpTool
        .rx
        .request(.LoginOut())
        .mapObject(Model.self)
        .asObservable()
    }
}
