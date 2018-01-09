//
//  ContactDetailsViewController.swift
//  EgoviOS-Swift
//
//  Created by 新龙科技 on 2018/1/9.
//  Copyright © 2018年 新龙科技. All rights reserved.
//

import UIKit
import RxSwift
import NSObject_Rx
class ContactDetailsViewController: UIViewController {
    @IBOutlet weak var headimg: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var position: UILabel!
    @IBOutlet weak var dept: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var ThePhone: UILabel!
    var id:NSInteger = 0
    let VM = AddressBookViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
    }
    @IBAction func Thephone(_ sender: UIButton) {
    }
    @IBAction func SMS(_ sender: UIButton) {
    }
    @IBAction func phone(_ sender: UIButton) {
    }
    @IBAction func Back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
extension ContactDetailsViewController {
    func initData() -> Void {
        VM.getUser(id: id).subscribe(onNext: { (model) in
            self.name.text = model.data?.realName!
            self.position.text = model.data?.deptName!
            self.dept.text = model.data?.parentName!
            self.phone.text = model.data?.phone!
            self.ThePhone.text = model.data?.telephone!
        }, onError: { (error) in
            print(error.localizedDescription)
        }).disposed(by: rx.disposeBag)
    }
}
