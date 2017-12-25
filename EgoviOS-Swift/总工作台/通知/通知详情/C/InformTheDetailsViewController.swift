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
import Alamofire
import MJRefresh
class InformTheDetailsViewController: BaseViewController {
    @IBOutlet weak var footView: UIView!
    @IBOutlet weak var rightbtn: UIButton!
    @IBOutlet weak var InformTheDetailsTableView: UITableView!
    var articleId = ""
    var model:InformTheDetailsModel?
    var Height:CGFloat?
    var idx = 0
    let VM = InformTheDetailsViewModel()
    let disposeBag = DisposeBag()
    var ForwardingBtn : UIButton?
    var RevertBtn : UIButton?
    @IBAction func back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func RightButton(_ sender: UIButton) {
        if (self.model?.data?.status_english! == "reply") {
            
        } else {
            
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
    
    public func Forwarding() -> Void {
        ForwardingBtn = CreateUI.Button(title: "转            发", frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH/2, height: 40), backgroundColor: UIColor.red, textColor: UIColor.white, font: 17)
        footView.addSubview(ForwardingBtn!)
    }
    
    public  func Revert() -> Void {
        RevertBtn = CreateUI.Button(title: "回            复", frame: CGRect(x: SCREEN_WIDTH/2, y: 0, width: SCREEN_WIDTH/2, height: 40), backgroundColor: UIColor.rgb(76, 171, 253, 1.0), textColor: UIColor.white, font: 17)
        footView.addSubview(RevertBtn!)
    }
    
    func ForwardingAndRevert() -> Void {
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
        if ((Zrole == "ROLE_OFFICE_SECRET") || (Zrole == "ROLE_DUTY_SECRET")) {
            
        } else {
            ForwardingBtn?.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
            RevertBtn?.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 40)
        }
    }
    
    public func createUI() -> Void {
        InformTheDetailsTableView.register(UINib.init(nibName: "InformTheDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "InformTheDetailsCell")
        InformTheDetailsTableView.separatorStyle = UITableViewCellSeparatorStyle(rawValue: 0)!
    }
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
extension InformTheDetailsViewController: UIWebViewDelegate {
    func webViewDidFinishLoad(_ webView: UIWebView) {
        Height = webView.sizeThatFits(CGSize.zero).height
        if idx <= 2 {
            InformTheDetailsTableView.reloadData()
        }
        idx += 1
    }
}
