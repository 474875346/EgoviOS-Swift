//
//  InformTheDetailsViewController.swift
//  EgoviOS-Swift
//
//  Created by 新龙科技 on 2017/12/19.
//  Copyright © 2017年 新龙科技. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Alamofire
import MJRefresh
class InformTheDetailsViewController: BaseViewController {
    @IBOutlet weak var footView: UIView!
    @IBOutlet weak var rightbtn: UIButton!
    @IBOutlet weak var InformTheDetailsTableView: UITableView!
    var Height:CGFloat?
    var idx = 0
    var articleId = ""
    var status = ""
    var model:InformTheDetailsModel?
    let VM = InformTheDetailsViewModel()
    let disposeBag = DisposeBag()
    var ForwardingBtn : UIButton?
    var RevertBtn : UIButton?    
    @IBAction func back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func RightButton(_ sender: UIButton) {
        if (self.model?.data?.status_english! != "reply") {
            let vc = PeopleRespondViewController()
            vc.id = NSInteger(articleId)!
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = AttendeesViewController()
            vc.id = NSInteger(articleId)!
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()
        Forwarding()
        Revert()
        initData()
    }
}
extension InformTheDetailsViewController {
    //MARK:填写回复提示框
    public func initreplyAlert() -> Void {
        let alertController = UIAlertController(title: "", message: "请填写回复内容", preferredStyle: .alert)
        alertController.addTextField(configurationHandler: nil)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "确定", style: .default) { (action) in
            let text = alertController.textFields![0].text!
            self.initreplyData(text)
        }
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    //MARK:一般通知回复请求
    public func initreplyData(_ reply : String) -> Void {
        VM.downArticle(id: articleId, replay: reply, persons: "").subscribe(onNext: { (model) in
            if model.status! == 200 {
                self.SuccessTost(Title: "", Body: "提交成功")
                self.navigationController?.popViewController(animated: true)
            } else {
                self.WaringTost(Title: "", Body: model.msg!)
            }
        }, onError: { (error) in
            print(error.localizedDescription)
            self.ErrorTost()
        }).disposed(by: disposeBag)
    }
    //MARK:会议通知回复
    public func initreplyVC() -> Void {
        
    }
    public func Forwarding() -> Void {
        ForwardingBtn = CreateUI.Button(title: "转            发", frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH/2, height: 40), backgroundColor: UIColor.red, textColor: UIColor.white, font: 17)
        ForwardingBtn?.rx.tap.asObservable().subscribe(onNext: { _ in
            let vc = ForwardingViewController()
            vc.status = "通知"
            self.navigationController?.pushViewController(vc, animated: true)
        }).disposed(by: disposeBag)
        footView.addSubview(ForwardingBtn!)
    }
    public func Revert() -> Void {
        RevertBtn = CreateUI.Button(title: "回            复", frame: CGRect(x: SCREEN_WIDTH/2, y: 0, width: SCREEN_WIDTH/2, height: 40), backgroundColor: UIColor.rgb(76, 171, 253, 1.0), textColor: UIColor.white, font: 17)
        RevertBtn?.rx.tap.asObservable().subscribe(onNext: { _ in
            self.status == "ybtz" ? self.initreplyAlert() : self.initreplyVC()
        }).disposed(by: disposeBag)
        footView.addSubview(RevertBtn!)
    }
    //MARK:底视图按钮判断
    public func ForwardingAndRevert() -> Void {
        if ( (Zrole == "ROLE_DEPT_SECRET") || (Zrole == "ROLE_DEPT_INFO")) {
            if model?.data?.status! == "已回复" {
                ForwardingBtn?.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 40)
                RevertBtn?.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
            }
        }
        if model?.data?.status! == "已回复" {
            footView.snp.remakeConstraints({ (make) in
                make.height.equalTo(0)
            })
            return
        }
        if (!(Zrole == "ROLE_OFFICE_SECRET") || (Zrole == "ROLE_DUTY_SECRET")) {
            ForwardingBtn?.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
            RevertBtn?.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 40)
        }
    }
    public func createUI() -> Void {
        InformTheDetailsTableView.register(UINib.init(nibName: "InformTheDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "InformTheDetailsCell")
        InformTheDetailsTableView.separatorStyle = UITableViewCellSeparatorStyle(rawValue: 0)!
    }
    //MARK:通知详情请求
    public func initData() -> Void {
        VM.getArticleView(articleId: articleId).subscribe(onNext: { (Model) in
            self.model = Model
            if self.model?.status == 200 {
                self.InformTheDetailsTableView.reloadData()
            } else {
                self.WaringTost(Title: "", Body: self.model?.msg! ?? String())
            }
            if (self.model?.data?.articleDetailSize! != 0) {
                self.rightbtn.isHidden = false
                self.rightbtn.setTitle("查看发送人员", for: UIControlState(rawValue: 0))
            }
            if (self.model?.data?.status_english! == "reply") {
                self.rightbtn.isHidden = false
                self.rightbtn.setTitle("查看回复信息", for: UIControlState(rawValue: 0))
            }
            self.ForwardingAndRevert()
        }, onError: { (error) in
            print(error.localizedDescription)
            self.ErrorTost()
        }).disposed(by:disposeBag)
    }
}
//MARK:表格代理
extension InformTheDetailsViewController:UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 2 {
            return model?.data?.datas?.count ?? Int()
        }
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 84
        } else if indexPath.section == 1 {
            return Height ?? CGFloat()
        } else {
            return 44
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:InformTheDetailsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "InformTheDetailsCell") as! InformTheDetailsTableViewCell
        if indexPath.section == 0 {
            cell.title.text = self.model?.data?.title!
            cell.time.text = self.model?.data?.sendTime!
        } else if indexPath.section == 1 {
            cell.webView.isHidden = false
            cell.webView.scrollView.bounces = false;
            cell.webView.delegate = self
            cell.webView.loadHTMLString(self.model?.data?.summary ?? String(), baseURL: nil)
        } else {
            cell.imageView?.image = UIImage(named: "附件")
            cell.textLabel?.text = self.model?.data?.datas![indexPath.row].name!
        }
        cell.selectionStyle = UITableViewCellSelectionStyle(rawValue: 0)!
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 2 {
            let id = self.model?.data?.datas![indexPath.row].id!
            let urlString = "http://47.95.5.138:8888/app/api/article/download?app_token=\(UserDefauTake(Key: ZToken)!)&client=\(deviceUUID!)&attachId=\(id!)"
            Alamofire.download(urlString, to: DefaultDownloadDestination).response { response in
                let path = response.destinationURL!.absoluteString
                let vc = AttachmentViewController()
                vc.path = path
                self.present(vc, animated: true, completion: nil)
            }
        }
    }
}
//MARK:web代理
extension InformTheDetailsViewController: UIWebViewDelegate {
    func webViewDidFinishLoad(_ webView: UIWebView) {
        self.Height = webView.sizeThatFits(CGSize.zero).height
        if self.idx <= 2 {
            self.InformTheDetailsTableView.reloadData()
        }
        self.idx += 1
    }
}
