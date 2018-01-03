//
//  AttendeesViewModel.swift
//  EgoviOS-Swift
//
//  Created by 新龙科技 on 2018/1/2.
//  Copyright © 2018年 新龙科技. All rights reserved.
//

import UIKit
import RxSwift
class AttendeesViewModel: NSObject {
    func viewReply(id:NSInteger) -> Observable<AttendeesModel> {
        return HttpTool
            .rx
            .request(.viewReply(id: id))
            .mapObject(AttendeesModel.self)
            .asObservable()
    }
}
