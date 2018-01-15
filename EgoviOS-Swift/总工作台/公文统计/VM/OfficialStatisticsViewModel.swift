//
//  OfficialStatisticsViewModel.swift
//  EgoviOS-Swift
//
//  Created by 新龙科技 on 2018/1/12.
//  Copyright © 2018年 新龙科技. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx
enum RefreshStatus {
    case none
    case beingHeaderRefresh
    case endHeaderRefresh
    case beingFooterRefresh
    case endFooterRefresh
    case noMoreData
}
class OfficialStatisticsViewModel: BaseModel {
    // 存放着解析完成的模型数组
    let models = Variable<[OfficialStatisticsData]>([])
    // 记录当前的索引值
    var index: Int = 1
    private func toDoList(Parameters:[String:Any]) -> Observable<OfficialStatisticsModel> {
        return HttpTool
            .rx
            .request(.toDoList(Parameters: Parameters))
            .mapObject(OfficialStatisticsModel.self)
            .asObservable()
    }
}
extension OfficialStatisticsViewModel {
    struct OfficialStatisticsOutput {
        // 外界通过该属性告诉viewModel加载数据（传入的值是为了标志是否重新加载）
        let requestCommond = PublishSubject<Bool>()
        // 告诉外界的tableView当前的刷新状态
        let refreshStatus = Variable<RefreshStatus>(.none)
    }
    
    func transform(_ leaderType : String, type : String) -> OfficialStatisticsViewModel.OfficialStatisticsOutput {
        let output = OfficialStatisticsOutput()
        output.requestCommond.subscribe(onNext: { (isReloadData) in
            self.index = isReloadData ? 1 : self.index + 1
            self.toDoList(Parameters: ["app_token":UserDefauTake(Key: ZToken)!,"client":deviceUUID!,"leaderType":leaderType,"type":type,"pageNumber":self.index]).subscribe(onNext: { (Model) in
                self.models.value = isReloadData ? Model.data : self.models.value+Model.data
                output.refreshStatus.value = isReloadData ? .endHeaderRefresh : .endFooterRefresh
                output.refreshStatus.value = Model.Isnumber ? .endFooterRefresh : .noMoreData
            }, onError: { (error) in
                print(error.localizedDescription)
            }).disposed(by: self.rx.disposeBag)
        }).disposed(by: rx.disposeBag)
        return output
    }
}
