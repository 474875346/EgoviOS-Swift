//
//  WorktableViewModel.swift
//  EgoviOS-Swift
//
//  Created by 新龙科技 on 2018/1/3.
//  Copyright © 2018年 新龙科技. All rights reserved.
//

import UIKit
import RxDataSources
struct LXFModel {
    var title = ""
}
struct LXFSection {
    // items就是rows
    var items: [Item]
    // 你也可以这里加你需要的东西，比如 headerView 的 title
}
extension LXFSection: SectionModelType {
    
    // 重定义 Item 的类型为 LXFModel
    typealias Item = LXFModel
    
    // 实现协议中的方式
    init(original: LXFSection, items: [LXFSection.Item]) {
        self = original
        self.items = items
    }
}
