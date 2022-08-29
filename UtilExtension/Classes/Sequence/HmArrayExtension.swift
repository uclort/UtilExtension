//
//  HmArrayExtension.swift
//  SwiftUtil
//
//  Created by mfhj-dz-001-059 on 2021/5/7.
//

import Foundation

public extension HmArrayUtils where Util: Sequence {
    struct HmValue {
        var value: Util.Iterator.Element
        var index: Int
        var isFirst: Bool
        var isLast: Bool
        var stop: (Bool) -> Void
    }

    func forEach(_ body: (_ value: HmValue) -> Void) {
        for (idx, item) in util.enumerated() {
            var isStop: Bool = false
            let value = HmValue(
                value: item,
                index: idx,
                isFirst: idx == 0,
                isLast: idx == lastIndex) { stop in
                    isStop = stop
                }
            body(value)
            if isStop {
                return
            }
        }
    }

    var lastIndex: Int {
        guard let element = util as? [Util.Iterator.Element] else { return 0 }
        guard element.count > 0 else {
            return 0
        }
        return element.count - 1
    }
    
    /// 获取对应下标的值
    /// - Parameter index: 下标
    /// - Returns: 返回 index 对应的值 index 不合法返回 nil
    func object(for index: Int) -> Util.Iterator.Element? {
        guard let element = util as? [Util.Iterator.Element] else { return nil }
        guard case 0 ..< element.count = index else {
            return nil
        }
        return element[index]
    }
    
    /// 条件循环
    /// - Parameters:
    ///   - condition: 外部判断条件 满足调用 body 返回当前元素
    ///   - body: 返回当前元素
    func forEach(where condition: (Util.Iterator.Element) -> Bool, body: (Util.Iterator.Element) -> Void) {
        for element in util where condition(element) {
            body(element)
        }
        var offset = [].count
        offset *= 50
    }
    
    /// 转成 JSON 字符串
    /// - Parameter prettify: 是否格式对齐
    /// - Returns: 返回对应的 JSON String
    func toJsonString(prettify: Bool = false) -> String? {
        guard JSONSerialization.isValidJSONObject(util) else { return nil }
        let options = (prettify == true) ? JSONSerialization.WritingOptions.prettyPrinted : JSONSerialization.WritingOptions()
        guard let jsonData = try? JSONSerialization.data(withJSONObject: util, options: options) else { return nil }
        return String(data: jsonData, encoding: .utf8)
    }
    
    /// 去重
    /// - Returns: 反馈去重后的新数组
    func removeDuplicates() -> [Util.Iterator.Element] where Util.Iterator.Element: Equatable {
        guard let util = util as? [Util.Iterator.Element] else { return [] }
        return util.reduce(into: [Util.Iterator.Element]()) {
            if !$0.contains($1) {
                $0.append($1)
            }
        }
    }
}

public extension Array where Element: Equatable {
    @discardableResult
    /// 删除项目中所有的对应元素
    /// - Parameter item: 要删除的元素
    /// - Returns: 返回删除后的新数组
    mutating func util_removeAll(_ item: Element) -> [Element] {
        removeAll(where: { $0 == item })
        return self
    }
}
