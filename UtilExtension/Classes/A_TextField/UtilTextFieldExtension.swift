//
//  UtilTextFieldExtension.swift
//  UtilExtension
//
//  Created by 侯猛 on 2022/8/6.
//

import Foundation

public extension UclortExtensionVariableUtil where Util: UITextField {
    /// 设置占位符颜色
    /// - Parameter color: 颜色
    func setPlaceHolderTextColor(_ color: UIColor) {
        guard let holder = util.placeholder, !holder.isEmpty else { return }
        util.attributedPlaceholder = NSAttributedString(string: holder, attributes: [.foregroundColor: color])
    }

    /// 清空输入框内容
    func clear() {
        util.text = ""
        util.attributedText = NSAttributedString(string: "")
    }
}
