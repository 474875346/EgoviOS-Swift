//
//  AddressGetAllUserByDeptViewController.swift
//  EgoviOS-Swift
//
//  Created by 新龙科技 on 2018/1/9.
//  Copyright © 2018年 新龙科技. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx
class AddressGetAllUserByDeptViewController: BaseViewController {
    @IBOutlet weak var GetAllUserByDeptSearch: UISearchBar!
    @IBOutlet weak var GetAllUserByDeptTable: UITableView!
    let AddressData = Variable<[AddressGetAllUserByDeptData]>([])
    var id:NSInteger = 0
    let VM = AddressBookViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addNavBackImg()
        self.addNavTitle(Title: "通讯录")
        self.addBackButton()
        initData()
        createUI()
    }
}
extension AddressGetAllUserByDeptViewController {
    func initData() -> Void {
        VM.getAllUserByDept(id: id).subscribe(onNext: { (model) in
            self.AddressData.value = model.data
        }, onError: { (error) in
            print(error.localizedDescription)
        }).disposed(by: rx.disposeBag)
    }
    func createUI() -> Void {
        GetAllUserByDeptTable.register(UINib.init(nibName: "AddressBookTableViewCell", bundle: nil), forCellReuseIdentifier: "AddressBookCell")
        //MARK:表格赋值
        AddressData.asDriver().drive(GetAllUserByDeptTable.rx.items(cellIdentifier: "AddressBookCell", cellType: AddressBookTableViewCell.self)){
            (row,element,cell) in
            cell.headerLabel.text = (element.deptName! as NSString).substring(to: 1)
            cell.title.text = element.deptName!
            cell.number.text = element.userNum!
            cell.selectionStyle = UITableViewCellSelectionStyle(rawValue: 0)!
            }.disposed(by: rx.disposeBag);
        //MARK:表格点击
        GetAllUserByDeptTable.rx.modelSelected(AddressGetAllUserByDeptData.self).subscribe(onNext: { (model) in
            if model.deptChild! == "N" {
                let VC = AddressGetUserByDeptIdViewController()
                VC.id = model.deptId!
                self.navigationController?.pushViewController(VC, animated: true)
            } else {
                let VC = AddressGetAllUserByDeptViewController()
                VC.id = model.deptId!
                self.navigationController?.pushViewController(VC, animated: true)
            }
        }, onError: { (error) in
            print(error.localizedDescription)
        }).disposed(by: rx.disposeBag)
    }
}
