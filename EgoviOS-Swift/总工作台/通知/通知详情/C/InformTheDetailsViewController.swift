//
//  InformTheDetailsViewController.swift
//  EgoviOS-Swift
//
//  Created by 新龙科技 on 2017/12/19.
//  Copyright © 2017年 新龙科技. All rights reserved.
//

import UIKit
import RxSwift
import Alamofire
import MJRefresh
class InformTheDetailsViewController: BaseViewController {
    @IBOutlet weak var InformTheDetailsTableView: UITableView!
    var articleId = ""
    var model:InformTheDetailsModel?
    var height:CGFloat?
    var idx = 1
    let VM = InformTheDetailsViewModel()
    let disposeBag = DisposeBag()
    @IBAction func back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()
    }
    public func createUI() -> Void {
        InformTheDetailsTableView.register(UINib.init(nibName: "InformTheDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "InformTheDetailsCell")
        InformTheDetailsTableView.separatorStyle = UITableViewCellSeparatorStyle(rawValue: 0)!
        InformTheDetailsTableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            self.initData()
        })
        InformTheDetailsTableView.mj_header.beginRefreshing()
    }
    func initData() -> Void {
        VM.getArticleView(articleId: articleId).subscribe(onNext: { (Model) in
            self.model = Model
            if self.model?.status == 200 {
                self.InformTheDetailsTableView.reloadData()
            } else {
                self.WaringTost(Title: "", Body: self.model?.msg! ?? String())
            }
            self.InformTheDetailsTableView.mj_header.endRefreshing()
        }, onError: { (error) in
            print(error.localizedDescription)
            self.ErrorTost()
            self.InformTheDetailsTableView.mj_header.endRefreshing()
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
            return height ?? CGFloat()
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
        height = webView.sizeThatFits(CGSize.zero).height
        if idx <= 2 {
            InformTheDetailsTableView.reloadData()
        }
        idx += 1
    }
}
