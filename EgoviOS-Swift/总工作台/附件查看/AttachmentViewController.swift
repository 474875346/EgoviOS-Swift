//
//  AttachmentViewController.swift
//  EgoviOS-Swift
//
//  Created by 新龙科技 on 2017/12/19.
//  Copyright © 2017年 新龙科技. All rights reserved.
//

import UIKit
import QuickLook
class AttachmentViewController: QLPreviewController,QLPreviewControllerDelegate,QLPreviewControllerDataSource{
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return 1
    }
    
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        return URL(string: path)! as QLPreviewItem
    }
    func previewControllerWillDismiss(_ controller: QLPreviewController) {
        do {
            try FileManager.default.removeItem(atPath: path)
        } catch  {
            print("附件没被删除")
        }
    }
    var path = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self;
        self.dataSource = self;
    }
}
