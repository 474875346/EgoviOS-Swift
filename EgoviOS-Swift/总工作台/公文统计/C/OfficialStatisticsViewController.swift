//
//  OfficialStatisticsViewController.swift
//  EgoviOS-Swift
//
//  Created by 新龙科技 on 2018/1/12.
//  Copyright © 2018年 新龙科技. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx
import MJRefresh
import LYEmptyView
class OfficialStatisticsViewController: BaseViewController {
    var Title = "市长专件"
    var leaderType = "1"
    var type = "welcome_to_do"
    @IBOutlet weak var OfficialStatisticsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addNavBackImg()
        self.addNavTitle(Title: Title)
        self.addBackButton()
        BindView()
        OfficialStatisticsTable.mj_header.beginRefreshing()
    }
}
extension OfficialStatisticsViewController {
    private func BindView() -> Void {
        OfficialStatisticsTable.backgroundColor = UIColor.rgb(234, 235, 236, 1.0)
        OfficialStatisticsTable.register(UINib.init(nibName: "MessageTableViewCell", bundle: nil), forCellReuseIdentifier: "MessageCell")
        self.OfficialStatisticsTable.ly_emptyView = LYEmptyView.emptyActionView(withImageStr: "无数据", titleStr: "无数据", detailStr: "", btnTitleStr: "重新加载", btnClick: {
            self.OfficialStatisticsTable.mj_header.beginRefreshing()
        })
        self.OfficialStatisticsTable.ly_startLoading()
        let VM = OfficialStatisticsViewModel()
        let reashVM = VM.transform(leaderType, type: type)
        VM.models.asDriver().drive(OfficialStatisticsTable.rx.items(cellIdentifier: "MessageCell", cellType: MessageTableViewCell.self)){
            (row, element, cell) in
            cell.title.text = element.title
            cell.time.text = element.time
            cell.status.text = element.status
            cell.deptName.text = element.deptName
            cell.status.textColor = UIColor(hexString: element.status_color!)
            cell.urgent.text = element.urgent
            cell.urgent.textColor = UIColor(hexString: element.urgent_color!)
            cell.selectionStyle = UITableViewCellSelectionStyle(rawValue: 0)!
            }.disposed(by: rx.disposeBag)
        reashVM.refreshStatus.asObservable().subscribe(onNext: {[weak self] status in
            switch status {
            case .beingHeaderRefresh:
                self?.OfficialStatisticsTable.mj_header.beginRefreshing()
            case .endHeaderRefresh:
                self?.OfficialStatisticsTable.mj_header.endRefreshing()
            case .beingFooterRefresh:
                self?.OfficialStatisticsTable.mj_footer.beginRefreshing()
            case .endFooterRefresh:
                self?.OfficialStatisticsTable.mj_footer.endRefreshing()
            case .noMoreData:
                self?.OfficialStatisticsTable.mj_footer.endRefreshingWithNoMoreData()
            default:
                break
            }
        }).disposed(by: rx.disposeBag)
        OfficialStatisticsTable.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            reashVM.requestCommond.onNext(true)
        })
        OfficialStatisticsTable.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: {
            reashVM.requestCommond.onNext(false)
        })
    }
}
