//
//  UtilCollectionExtension.swift
//  UtilExtension
//
//  Created by 侯猛 on 2022/8/8.
//

import Foundation

public extension UclortExtensionUtil where Util: Collection {
    /// 内容是否不为空
    var isNotEmpty: Bool {
        !util.isEmpty
    }
}

public extension RangeReplaceableCollection {
    @discardableResult
    /// 删除查找到的第一个元素并返回
    /// - Parameter predicate: 查找条件
    /// - Returns: 删除的元素
    mutating func utilRemoveFirst(where predicate: (Element) throws -> Bool) rethrows -> Element? {
        guard let index = try firstIndex(where: predicate) else { return nil }
        return remove(at: index)
    }
}
