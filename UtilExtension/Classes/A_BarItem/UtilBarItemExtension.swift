//
//  UtilBarItemExtension.swift
//  UtilExtension
//
//  Created by 侯猛 on 2022/8/10.
//

import Foundation

public extension UclortExtensionVariableUtil where Util: UIBarButtonItem {
    /// 创建一个 flexibleSpace 类型的 BarButtonItem
    static var flexibleSpace: UIBarButtonItem {
        UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    }

    
    /// 创建一个具有特定宽度的固定空间的 BarButtonItem
    /// - Parameter width: 宽度
    static func fixedSpace(width: CGFloat) -> UIBarButtonItem {
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        barButtonItem.width = width
        return barButtonItem
    }
    
    /// 添加选择器
    func addTargetForAction(_ target: AnyObject, action: Selector) {
        util.target = target
        util.action = action
    }
}
