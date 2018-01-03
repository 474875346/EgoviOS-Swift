//
//  PeopleRespondViewController.swift
//  EgoviOS-Swift
//
//  Created by 新龙科技 on 2018/1/2.
//  Copyright © 2018年 新龙科技. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
class PeopleRespondViewController: BaseViewController {
    
    @IBOutlet weak var PeopleRespondTableView: UITableView!
    var id:NSInteger = 0
    let VM = PeopleRespondViewModel()
    let disposeBag = DisposeBag()
    var Model = Variable<[PeopleRespondData]>([])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addNavBackImg()
        self.addNavTitle(Title: "发送人员详情")
        self.addBackButton()
        initData()
        createUI()
    }
}
extension PeopleRespondViewController {
    public  func createUI () -> Void {
        PeopleRespondTableView.register(UINib.init(nibName: "PeopleRespondCell", bundle: nil), forCellReuseIdentifier: "PeopleRespondCell")
        Model.asObservable().bind(to: PeopleRespondTableView.rx.items(cellIdentifier: "PeopleRespondCell", cellType: PeopleRespondCell.self)){
            (row, element, cell) in
            cell.userName.text = element.userName;
            cell.receiveTime.text = element.receiveTime;
            cell.userParentDpet.text = element.userParentDpet;
            cell.userDpet.text = element.userDpet;
            cell.status.text = element.status;
            cell.reply.text = element.reply;
            cell.selectionStyle = UITableViewCellSelectionStyle(rawValue: 0)!
            }.disposed(by: disposeBag)
    }
    public  func initData() -> Void {
        VM.viewDown(id: id).subscribe(onNext: { (Model) in
            self.Model.value = Model.data
        }, onError: { (error) in
            print(error.localizedDescription)
        }).disposed(by: disposeBag)
    }
}
