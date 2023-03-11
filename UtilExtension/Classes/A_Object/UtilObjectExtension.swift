//
//  UtilObjectExtension.swift
//  BaseExtension
//
//  Created by 侯猛 on 2022/10/22.
//

import Foundation

public extension UclortExtensionVariableUtil where Util: NSObject {
    /// 获取 Module name
    var moduleName: String {
        let classString = NSStringFromClass(type(of: util))
        return classString.components(separatedBy: ".").first.utilOr(for: "").util.empty(or: classString)
    }

    /// 获取 Class Name
    var className: String {
        let classString = NSStringFromClass(type(of: util))
        return classString.components(separatedBy: ".").last.utilOr(for: "").util.empty(or: classString)
    }
}
