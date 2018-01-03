//
//  ForwardingViewController.swift
//  EgoviOS-Swift
//
//  Created by 新龙科技 on 2017/12/27.
//  Copyright © 2017年 新龙科技. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
class ForwardingViewController: BaseViewController {
    @IBOutlet weak var ForwardingTableview: UITableView!
    @IBOutlet weak var ForwardingCollectionview: UICollectionView!
    var status = ""
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addNavBackImg()
        self.addNavTitle(Title: "转发")
        self.addBackButton()
        let rightbtn =  self.addRightButton(title: "选人")
        rightbtn.rx.tap.asObservable().subscribe(onNext: { _ in
            
        }).disposed(by:disposeBag )
        createUI()
    }
    @IBAction func summit(_ sender: UIButton) {
        
    }
}
extension ForwardingViewController {
    public func titleArray() -> Observable<Array<String>> {
        if  status == "通知" {
            return Observable.just(["是否发送短信"])
        } else {
             return Observable.just(["是否督办"])
        }
    }
    func createUI() -> Void {
        ForwardingTableview.register(UINib.init(nibName: "ForwardingTableViewCell", bundle: nil), forCellReuseIdentifier: "ForwardingCell")
        titleArray().bind(to: ForwardingTableview.rx.items(cellIdentifier: "ForwardingCell", cellType: ForwardingTableViewCell.self)){
            (row, element, cell) in
            cell.title.text = element
        }.disposed(by: disposeBag)
    }
}
