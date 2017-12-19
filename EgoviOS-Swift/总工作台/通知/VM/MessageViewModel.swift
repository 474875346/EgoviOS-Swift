//
//  MessageViewModel.swift
//  EgoviOS-Swift
//
//  Created by 新龙科技 on 2017/12/15.
//  Copyright © 2017年 新龙科技. All rights reserved.
//

import UIKit
import RxSwift
import MJRefresh
enum MessageResult {
    case ok(message:String)
    case empty
}
extension MessageResult {
    var description : String {
        switch self {
        case let .ok(message) :
            return message
        case .empty :
            return ""
        }
    }
}
class MessageViewModel: NSObject {
    let server = MessageService.instance
    func getArticleDetailIndex(page:Int,type:String) -> Observable<MessageModel> {
        return HttpTool
            .rx
            .request(.getArticleDetailIndex(page: page, type: type))
            .mapObject(MessageModel.self)
            .asObservable()
    }
    func SegmentedSelectedSegmentIndex(index:Observable<Int>) -> Observable<MessageResult> {
        return   index.flatMapLatest { idx  in
            return self.server.SegmentedSelectionidx(idx)
        }
    }
}
class MessageService {
    //MARK:单例类
    static let instance = MessageService()
    private init() {}
    func SegmentedSelectionidx (_ index:Int) -> Observable<MessageResult> {
        switch index {
        case 0:
            return Observable.just(MessageResult.ok(message: "ybtz"))
        case 1:
            return Observable.just(MessageResult.ok(message: "hytz"))
        default:
            return Observable.just(MessageResult.empty)
        }
    }
}
