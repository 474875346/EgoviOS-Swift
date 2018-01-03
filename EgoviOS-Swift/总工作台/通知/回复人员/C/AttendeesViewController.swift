//
//  AttendeesViewController.swift
//  EgoviOS-Swift
//
//  Created by 新龙科技 on 2018/1/2.
//  Copyright © 2018年 新龙科技. All rights reserved.
//

import UIKit
import RxSwift
class AttendeesViewController: BaseViewController {
    @IBOutlet weak var AttendeesTableView: UITableView!
    var id:NSInteger = 0
    var reply = ""
    let disposeBag = DisposeBag()
    var Model = Variable<[AttendeesReplypersons]>([])
    let VM = AttendeesViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addNavBackImg()
        self.addNavTitle(Title: "回复人员详情")
        self.addBackButton()
        initData()
        createUI()
    }
}
extension AttendeesViewController {
    public func createUI() -> Void {
        AttendeesTableView.register(UINib.init(nibName: "AttendeesTableViewCell", bundle: nil), forCellReuseIdentifier: "AttendeesCell")
        AttendeesTableView.tableHeaderView = headerView()
        Model.asObservable().bind(to: AttendeesTableView.rx.items(cellIdentifier: "AttendeesCell", cellType: AttendeesTableViewCell.self)){
            (row, element, cell) in
            cell.name.text = element.name;
            cell.phone.text = element.phone;
            cell.company.text = element.company;
            cell.post.text = element.post;
            cell.selectionStyle = UITableViewCellSelectionStyle(rawValue: 0)!
            }.disposed(by: disposeBag)
    }
    public  func initData() -> Void {
        VM.viewReply(id: id).subscribe(onNext: { (Model) in
            guard let Modelreply = Model.reply else { return  }
            self.reply = Modelreply
            self.Model.value = Model.data
        }, onError: { (error) in
            print(error.localizedDescription)
        }).disposed(by: disposeBag)
    }
    func headerView() -> UIView {
        let header = CreateUI.Label(textColor: UIColor.black, backgroundColor: UIColor.clear, title: "  回复内容:\n\(reply)", frame: CGRect(x: 0, y: 10, width: SCREEN_WIDTH, height: 40), font: 15)
        header.sizeToFit()
        return header
    }
}
