//
//  MessageRefreshViewModel.swift
//  EgoviOS-Swift
//
//  Created by 新龙科技 on 2017/12/18.
//  Copyright © 2017年 新龙科技. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

enum LXFRefreshStatus {
    case none
    case beingHeaderRefresh
    case endHeaderRefresh
    case beingFooterRefresh
    case endFooterRefresh
    case noMoreData
}

class MessageRefreshViewModel: BaseModel {
    // 存放着解析完成的模型数组
    let models = Variable<[MessageData]>([])
    // 记录当前的索引值
    var index: Int = 1
    var result:String = "ybhy"
    //内存释放
    let disposeBag = DisposeBag()
}
extension MessageRefreshViewModel {
    struct MessageOutput {
        // 外界通过该属性告诉viewModel加载数据（传入的值是为了标志是否重新加载）
        let requestCommond = PublishSubject<Bool>()
        // 告诉外界的tableView当前的刷新状态
        let refreshStatus = Variable<LXFRefreshStatus>(.none)
    }
    
    func transform(input: Observable<MessageResult>,VM:MessageViewModel) -> MessageRefreshViewModel.MessageOutput {
        let output = MessageOutput()
        input.subscribe({ (reulst) in
            self.result = reulst.element!.description
            output.requestCommond.onNext(true)
        }).disposed(by: self.disposeBag)
        output.requestCommond.subscribe(onNext: { (isReloadData) in
            self.index = isReloadData ? 1 : self.index + 1
            VM.getArticleDetailIndex(page: self.index, type: self.result).subscribe({ (event) in
                switch event {
                case let .next(model):
                    self.models.value = isReloadData ? model.data : self.models.value + model.data
                    model.status == 200 ? self.SuccessTost(Title: "", Body: "获取数据成功") : self.WaringTost(Title: "", Body: model.msg!)
                    output.refreshStatus.value = isReloadData ? .endHeaderRefresh : .endFooterRefresh
                    output.refreshStatus.value = model.Isnumber ? .endFooterRefresh : .noMoreData
                case let .error(error):
                    print(error.localizedDescription)
                    self.ErrorTost()
                    output.refreshStatus.value = isReloadData ? .endHeaderRefresh : .noMoreData
                case .completed:
                    break
                }
            }).disposed(by: self.disposeBag)
        }).disposed(by: disposeBag)
        return output
    }
}
