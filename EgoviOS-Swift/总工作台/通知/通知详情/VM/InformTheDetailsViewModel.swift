//
//  InformTheDetailsViewModel.swift
//  EgoviOS-Swift
//
//  Created by 新龙科技 on 2017/12/19.
//  Copyright © 2017年 新龙科技. All rights reserved.
//

import UIKit
import RxSwift
class InformTheDetailsViewModel: NSObject {
    func getArticleView(articleId:String) -> Observable<InformTheDetailsModel> {
        return HttpTool
            .rx
            .request(.getArticleView(articleId: articleId))
            .mapObject(InformTheDetailsModel.self)
            .asObservable()
    }
}

