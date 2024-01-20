//
//  UtilSearchBarExtension.swift
//  UtilExtension
//
//  Created by 侯猛 on 2022/8/6.
//

import Foundation

public extension UclortExtensionVariableUtil where Util: UISearchBar {
    /// 获取输入框对象
    var textField: UITextField? {
        if #available(iOS 13.0, *) {
            return util.searchTextField
        }
        let subViews = util.subviews.flatMap { $0.subviews }
        guard let textField = (subViews.filter { $0 is UITextField }).first as? UITextField else {
            return nil
        }
        return textField
    }

    /// 去掉空白和换行
    var trimmedText: String? {
        return util.text?.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
