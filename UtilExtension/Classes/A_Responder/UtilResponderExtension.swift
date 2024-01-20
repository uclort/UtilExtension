//
//  UtilResponderExtension.swift
//  Pods
//
//  Created by 侯猛 on 3/12/23.
//

import Foundation

public extension UclortExtensionVariableUtil where Util == UIResponder {
    /// 收起键盘
    static func resignFirstResponder() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
