//
//  UtilOptionalExtension.swift
//  UtilExtension
//
//  Created by 侯猛 on 2022/9/2.
//

import Foundation

public extension Optional {
    /// 是否为 nil
    var utilIsNone: Bool {
        switch self {
        case .none:
            return true
        case .some:
            return false
        }
    }

    /// 返回可选值或表达式的值
    /// 可选值为 nil 则返回 expression 表达式的值
    func utilOr(for expression: @autoclosure () -> Wrapped) -> Wrapped {
        self ?? expression()
    }

    /// 返回可选值或 condition 表达式返回的值
    /// 可选值为 nil 则返回 condition 闭包值
    func utilOr(for condition: () -> Wrapped) -> Wrapped {
        self ?? condition()
    }

    /// 可选值不为空且可选值满足 `condition` 条件才返回，否则返回 `nil`
    func utilFilter(for condition: (Wrapped) -> Bool) -> Wrapped? {
        guard let unwrapped = self,
              condition(unwrapped)
        else { return nil }
        return unwrapped
    }
}

public extension Optional where Wrapped == String {
    /// 非空字符串内容
    /// nil 和 "" 都返回 nil
    var utilNotBlank: String? {
        utilFilter(for: { $0.util.isNotEmpty })
    }
}
