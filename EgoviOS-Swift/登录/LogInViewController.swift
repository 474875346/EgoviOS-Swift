//
//  LogInViewController.swift
//  EgoviOS-Swift
//
//  Created by 新龙科技 on 2017/12/15.
//  Copyright © 2017年 新龙科技. All rights reserved.
//

import UIKit
import RxSwift
class LogInViewController: BaseViewController {
    
    @IBOutlet weak var nametextField: UITextField!
    @IBOutlet weak var pswtextField: UITextField!
    let disposeBag = DisposeBag()
    let viewModel  = ViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        pswtextField.isSecureTextEntry = true
        guard (UserDefauTake(Key: ZToken) != nil) else {
            return
        }
        createTabbar()
    }
    @IBAction func Login(_ sender: UIButton) {
        viewModel.initLogin(name: nametextField.text!, psw: pswtextField.text!).subscribe(onNext: { (model) in
            if model.status == 200 {
                self.SuccessTost(Title: "", Body: "登录成功")
                UserDefaultSave(Key: ZToken, Value: model.data?.access_token)
                UserDefaultSave(Key: Zcode,Value: model.code)
                UserDefaultSave(Key: ZDept, Value: model.data?.dept)
                UserDefaultSave(Key: Zduty, Value: model.data?.duty)
                UserDefaultSave(Key: ZrealName, Value: model.data?.realName)
                self.createTabbar()
                self.nametextField.text = nil
                self.pswtextField.text = nil
            } else {
                self.WaringTost(Title: "", Body: model.msg!)
            }
        }, onError: { (error) in
            print(error)
            self.ErrorTost()
        }).disposed(by: disposeBag)
    }
}
extension LogInViewController {
    func createTabbar() -> Void {
        let tabbar = UITabBarController()
        tabbar.tabBar.backgroundColor = UIColor.white
        tabbar.tabBar.isTranslucent = false
        tabbar.tabBar.tintColor = UIColor.rgb(76, 171, 253, 1.0)
        tabbar.viewControllers = createTabBarItems()
        tabbar.selectedIndex = 1
        let nav = UINavigationController(rootViewController: tabbar)
        nav.navigationBar.isHidden = true
        _ = [self.present(nav, animated: false, completion: nil)]
    }
    func createTabBarItems() -> Array<UIViewController> {
        let classArray = [MessageViewController(), WorktableViewController(),
                          AddressBookViewController()]
        let imgArray = ["通知", "工作台", "通讯录"]
        for (idx,obj) in classArray.enumerated() {
            addChildVc(childVc: obj, title: imgArray[idx], image: imgArray[idx])
        }
        return classArray
    }
    func addChildVc(childVc:UIViewController,title:String,image:String) -> Void {
        childVc.automaticallyAdjustsScrollViewInsets = false
        childVc.tabBarItem.title = title;
        childVc.tabBarItem.image = UIImage(named: image);
    }
}
