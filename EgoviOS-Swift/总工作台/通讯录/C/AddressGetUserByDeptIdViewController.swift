//
//  AddressGetUserByDeptIdViewController.swift
//  EgoviOS-Swift
//
//  Created by 新龙科技 on 2018/1/9.
//  Copyright © 2018年 新龙科技. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx
class AddressGetUserByDeptIdViewController: BaseViewController {
    @IBOutlet weak var AddressGetUserByDeptIdSearch: UISearchBar!
    @IBOutlet weak var AddressGetUserByDeptIdTable: UITableView!
    var id:NSInteger = 0
    let VM = AddressBookViewModel()
    let AddressData = Variable<[AddressGetUserByDeptIdData]>([])
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addNavBackImg()
        self.addNavTitle(Title: "通讯录")
        self.addBackButton()
        initData()
        createUI()
    }
}
extension AddressGetUserByDeptIdViewController {
    func initData() -> Void {
        VM.getUserByDeptId(id: id).subscribe(onNext: { (model) in
            self.AddressData.value = model.data
        }, onError: { (error) in
            print(error.localizedDescription)
        }).disposed(by: rx.disposeBag)
    }
    func createUI() -> Void {
        AddressGetUserByDeptIdTable.register(UINib.init(nibName: "AddressBookTableViewCell", bundle: nil), forCellReuseIdentifier: "AddressBookCell")
        //MARK:表格赋值
        AddressData.asDriver().drive(AddressGetUserByDeptIdTable.rx.items(cellIdentifier: "AddressBookCell", cellType: AddressBookTableViewCell.self)){
            (row,element,cell) in
            cell.headerLabel.text = (element.realName! as NSString).substring(to: 1)
            cell.title.text = element.realName!
            cell.number.text = element.phone
            cell.selectionStyle = UITableViewCellSelectionStyle(rawValue: 0)!
            }.disposed(by: rx.disposeBag);
        //MARK:表格点击
        AddressGetUserByDeptIdTable.rx.modelSelected(AddressGetUserByDeptIdData.self).subscribe(onNext: { (model) in
            let VC = ContactDetailsViewController()
            VC.id = model.id!
            self.navigationController?.pushViewController(VC, animated: true)
        }, onError: { (error) in
            print(error.localizedDescription)
        }).disposed(by: rx.disposeBag)
    }
}
