//
//  AddressBookViewController.swift
//  EgoviOS-Swift
//
//  Created by 新龙科技 on 2017/12/15.
//  Copyright © 2017年 新龙科技. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
class AddressBookViewController: BaseViewController {
    @IBOutlet weak var search: UISearchBar!
    @IBOutlet weak var AddressBookTable: UITableView!
    let VM = AddressBookViewModel()
    let disposeBag = DisposeBag()
    let AddressData = Variable<[AddressBookData]>([])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addNavBackImg()
        self.addNavTitle(Title: "通讯录")
        initData()
        createUI()
    }
}
extension AddressBookViewController {
    private func createUI() -> Void {
        AddressBookTable.register(UINib.init(nibName: "AddressBookTableViewCell", bundle: nil), forCellReuseIdentifier: "AddressBookCell")
        AddressData.asDriver().drive(AddressBookTable.rx.items(cellIdentifier: "AddressBookCell", cellType: AddressBookTableViewCell.self)){
            (row,element,cell) in
            cell.headerLabel.text = (element.name! as NSString).substring(to: 1)
            cell.title.text = element.name!
            cell.number.text = element.userNum!
            cell.selectionStyle = UITableViewCellSelectionStyle(rawValue: 0)!
            }.disposed(by: disposeBag)
        AddressBookTable.rx.modelSelected(AddressBookData.self).subscribe(onNext: { (model) in
            let VC = AddressGetAllUserByDeptViewController()
            VC.id = model.id!
            self.navigationController?.pushViewController(VC, animated: true)
        }, onError: { (error) in
            print(error.localizedDescription)
        }).disposed(by: disposeBag)
    }
    private func initData() -> Void {
        ActivityIndicatorView.startAnimating()
        VM.getRootDept().subscribe(onNext: { (model) in
            self.AddressData.value = model.data
            model.status == 200 ? self.SuccessTost(Title: "", Body: "获取数据成功") : self.WaringTost(Title: "", Body: model.msg!)
            ActivityIndicatorView.stopAnimating()
        }, onError: { (error) in
            print(error.localizedDescription)
            self.ErrorTost()
            ActivityIndicatorView.stopAnimating()
        }).disposed(by: disposeBag)
    }
}
