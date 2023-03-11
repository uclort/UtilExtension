//
//  UtilNavigationBarExtension.swift
//  UtilExtension
//
//  Created by 侯猛 on 2022/8/6.
//

import Foundation

public extension UclortExtensionVariableUtil where Util: UINavigationBar {
    
    /// 设置导航栏颜色
    /// - Parameters:
    ///   - background: 颜色
    ///   - text: 文字
    func setColors(background: UIColor, text: UIColor) {
        util.isTranslucent = false
        util.backgroundColor = background
        util.barTintColor = background
        util.setBackgroundImage(UIImage(), for: .default)
        util.tintColor = text
        util.titleTextAttributes = [.foregroundColor: text]
    }
    
    /// 设置导航栏文字样式
    /// - Parameters:
    ///   - font: 字体
    ///   - color: 颜色
    func setTitleFont(_ font: UIFont, color: UIColor = .black) {
        var attrs = [NSAttributedString.Key: Any]()
        attrs[.font] = font
        attrs[.foregroundColor] = color
        util.titleTextAttributes = attrs
    }
}
