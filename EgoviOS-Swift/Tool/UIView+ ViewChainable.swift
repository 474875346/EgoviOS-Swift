//
//  UIView+ ViewChainable.swift
//  Swift-ViewChainable
//
//  Created by 新龙科技 on 2017/11/3.
//  Copyright © 2017年 新龙科技. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
protocol ViewChainable {}
extension ViewChainable where Self:UIView {
    @discardableResult
    func config(config:(Self)->Void) -> Self {
        config(self)
        return self
    }
}
extension UIView:ViewChainable {
    func adhere(toSuperView:UIView) -> Self {
        toSuperView.addSubview(self)
        return self
    }
    @discardableResult
    func layout(snapKitMaker:(ConstraintMaker)->Void) -> Self {
        self.snp.makeConstraints { (Make) in
            snapKitMaker(Make)
        }
        return self
    }
}

