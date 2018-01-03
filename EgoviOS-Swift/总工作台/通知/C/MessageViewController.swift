//
//  MessageViewController.swift
//  EgoviOS-Swift
//
//  Created by 新龙科技 on 2017/12/15.
//  Copyright © 2017年 新龙科技. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Then
import MJRefresh
import RxDataSources
class MessageViewController: BaseViewController {
    @IBOutlet weak var Segmented: UISegmentedControl!
    @IBOutlet weak var MessageTableView: UITableView!
    let disposeBag = DisposeBag()
    let MessageVM = MessageViewModel()
    let MessageRefreshVM = MessageRefreshViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindView()
        MessageTableView.backgroundColor = UIColor.rgb(234, 235, 236, 1.0)
        MessageTableView.register(UINib.init(nibName: "MessageTableViewCell", bundle: nil), forCellReuseIdentifier: "MessageCell")
        MessageTableView.mj_header.beginRefreshing()
    }
}
extension MessageViewController {
    fileprivate func bindView() -> Void {
        // 绑定cell
        let selectionIdx = MessageVM.SegmentedSelectedSegmentIndex(index: Segmented.rx.selectedSegmentIndex.asObservable())
        let reashVM = MessageRefreshVM.transform(input: selectionIdx, VM: MessageVM)
        MessageRefreshVM.models.asDriver().drive(MessageTableView.rx.items(cellIdentifier: "MessageCell", cellType: MessageTableViewCell.self)){
            (row, element, cell) in
            cell.title.text = element.title!
            cell.time.text = element.time!
            cell.urgent.text = element.status!
            cell.urgent.textColor = UIColor(hexString: element.statuColor!)
            cell.selectionStyle = UITableViewCellSelectionStyle(rawValue: 0)!
            }.disposed(by: disposeBag)
        MessageTableView.rx.modelSelected(MessageData.self).subscribe(onNext: { (model) in
            let vc = InformTheDetailsViewController()
            vc.articleId = "\(model.id!)"
            vc.status = self.MessageRefreshVM.result
            self.navigationController?.pushViewController(vc, animated: true)
        }, onError: { (error) in
            print(error.localizedDescription)
        }).disposed(by: disposeBag)
        reashVM.refreshStatus.asObservable().subscribe(onNext: {[weak self] status in
            switch status {
            case .beingHeaderRefresh:
                self?.MessageTableView.mj_header.beginRefreshing()
            case .endHeaderRefresh:
                self?.MessageTableView.mj_header.endRefreshing()
            case .beingFooterRefresh:
                self?.MessageTableView.mj_footer.beginRefreshing()
            case .endFooterRefresh:
                self?.MessageTableView.mj_footer.endRefreshing()
            case .noMoreData:
                self?.MessageTableView.mj_footer.endRefreshingWithNoMoreData()
            default:
                break
            }
        }).disposed(by: disposeBag)
        MessageTableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            reashVM.requestCommond.onNext(true)
        })
        MessageTableView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: {
            reashVM.requestCommond.onNext(false)
        })
    }
}
