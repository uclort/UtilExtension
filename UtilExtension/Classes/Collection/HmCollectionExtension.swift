//
//  HmCollectionExtension.swift
//  Pods
//
//  Created by 侯猛 on 2022/8/12.
//

import Foundation

public extension RangeReplaceableCollection {
    @discardableResult
    /// 删除查找到的第一个元素并返回
    /// - Parameter predicate: 查找条件
    /// - Returns: 删除的元素
    mutating func util_removeFirst(where predicate: (Element) throws -> Bool) rethrows -> Element? {
        guard let index = try firstIndex(where: predicate) else { return nil }
        return remove(at: index)
    }
}
