//
//  WorktableViewController.swift
//  EgoviOS-Swift
//
//  Created by 新龙科技 on 2017/12/15.
//  Copyright © 2017年 新龙科技. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import SnapKit
class WorktableViewController: BaseViewController {
    @IBOutlet weak var worktableCollection: UICollectionView!
    @IBOutlet weak var CardView: UIView!
    @IBOutlet weak var topview: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var duty: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var Welcome_return: UILabel!
    @IBOutlet weak var Other: UILabel!
    @IBOutlet weak var Director: UILabel!
    @IBOutlet weak var Mayor: UILabel!
    let VM = WorktableViewViewModel()
    let disposeBag = DisposeBag()
    var modelArray : Array<[LXFModel]> = []
    let dataSource = RxCollectionViewSectionedReloadDataSource<LXFSection>(configureCell: { ds, tv, ip, item in
        let cell = tv.dequeueReusableCell(withReuseIdentifier: "WorktableCell", for: ip) as! WorktableCollectionViewCell
        cell.img.image = UIImage(named: item.title)
        cell.title.text = item.title
        return cell
    })
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initMainpage()
        createUI()
        HomeDolistData()
    }
    @IBAction func SetUp(_ sender: UIButton) {
        JMDropMenu.showFrame(CGRect(x:X(sender)-100, y: YH(sender), width: 130, height: 90), arrowOffset: 110.0, titleArr: ["修改密码","退出登录"], imageArr: ["修改密码","退出登录"], type: .QQ, layoutType: .normal, rowHeight: 40.0, delegate: self)
    }

    @IBAction func HomeDolist(_ sender: UIButton) {
        
    }
    
}
extension WorktableViewController : JMDropMenuDelegate {
    func didSelectRow(at index: Int, title: String!, image: String!) {
        print(index,title,image)
        switch title {
        case "修改密码":
            self.WaringTost(Title: "", Body: "修改密码")
        case "退出登录":
            LoginOut()
        case .none: break
        case .some(_): break
        }
    }
    func LoginOut() -> Void {
        VM.LoginOut().subscribe(onNext: { (model) in
            if model.status! == 200 {
                self.SuccessTost(Title: "", Body: "退出登录成功")
                UserDefaultRemove(Key: ZToken)
                self.dismiss(animated: true, completion: nil)
            } else {
                self.WaringTost(Title: "", Body: model.msg!)
            }
        }, onError: { (error) in
            print(error.localizedDescription)
        }).disposed(by: disposeBag)
    }
    func HomeDolistData() -> Void {
        VM.HomeDolist().subscribe(onNext: { (model) in
            self.Director.text = model.data?.director
            self.Other.text = model.data?.other
            self.Welcome_return.text = model.data?.welcome_return
            self.Mayor.text = model.data?.mayor
        }, onError: { (error) in
            print(error.localizedDescription)
        }).disposed(by: rx.disposeBag)
    }
}
extension WorktableViewController{
    
    //    MARK:权限判断
    func initMainpage() -> Void {
        let role = UserDefauTake(Key: Zcode)! as! String
        if role == "ROLE_REGION" {
            modelArray = [[LXFModel(title: "公文管理"),LXFModel(title: "接待管理"),LXFModel(title: "专件传阅")],[LXFModel(title: "文件管理"),LXFModel(title: "日程管理"),LXFModel(title: "公示公告"),LXFModel(title: "值班管理"),LXFModel(title: "会议管理"),LXFModel(title: "企业查询")]]
        } else {
            modelArray = [[LXFModel(title: "公文管理"),LXFModel(title: "绩效考核"),LXFModel(title: "接待管理"),LXFModel(title: "考勤管理"),LXFModel(title: "专件传阅"),LXFModel(title: "信访管理")],[LXFModel(title: "公示公告"),LXFModel(title: "会议管理"),LXFModel(title: "企业查询"),LXFModel(title: "日程管理"),LXFModel(title: "文件管理"),LXFModel(title: "值班管理")]]
        }
        if role == "ROLE_DIRECTOR" {
            
        } else {
            CardView.snp.remakeConstraints({ (mask) in
                mask.height.equalTo(0)
            })
        }
        name.text = UserDefauTake(Key: ZrealName) as? String
        duty.text = UserDefauTake(Key: Zduty) as? String
        time.text = "\(getTimes()[0])年\(getTimes()[1])月\(getTimes()[2])日 \(getTimes()[6])"
        VM.MainpageConversion(modelArray)
    }
    
    func createUI() -> Void {
        worktableCollection.register(UINib.init(nibName: "WorktableCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "WorktableCell")
        VM.sections.asDriver().drive(worktableCollection.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
        worktableCollection.rx.modelSelected(LXFModel.self).subscribe(onNext: { (model) in
            print(model.title)
        }).disposed(by: disposeBag)
    }
}
