//
//  UtilArrayExtension.swift
//  UtilExtension
//
//  Created by 侯猛 on 2022/8/6.
//

import Foundation

public extension UclortExtensionArrayUtil where Util: Sequence {
    /// 遍历集合
    /// - Parameter body: 回调闭包
    ///     - value: 当前遍历元素
    ///     - index: 当前遍历下标
    ///     - isFirsh: 是否为第一个元素
    ///     - isLast: 是否为最后一个元素
    ///     - stop: 结束遍历闭包, 外包调用传入 true 则结束遍历
    func forEach(
        _ body: (
            _ item: Util.Iterator.Element,
            _ index: Int,
            _ isFirst: Bool,
            _ isLast: Bool,
            _ stop: (Bool) -> Void
        ) -> Void
    ) {
        for (idx, item) in util.enumerated() {
            var isStop: Bool = false
            body(item, idx, idx == 0, idx == lastIndex) { stop in
                isStop = stop
            }
            if isStop {
                return
            }
        }
    }

    /// 最后一个元素的下标
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

    /// 第二个元素
    var second: Util.Iterator.Element? {
        object(for: 1)
    }

    /// 第三个元素
    var third: Util.Iterator.Element? {
        object(for: 2)
    }

    /// 第四个元素
    var fourth: Util.Iterator.Element? {
        object(for: 3)
    }

    /// 第五个元素
    var fifth: Util.Iterator.Element? {
        object(for: 4)
    }

    /// 第六个元素
    var sixth: Util.Iterator.Element? {
        object(for: 5)
    }

    /// 第七个元素
    var seventh: Util.Iterator.Element? {
        object(for: 6)
    }

    /// 第八个元素
    var eighth: Util.Iterator.Element? {
        object(for: 7)
    }

    /// 第九个元素
    var ninth: Util.Iterator.Element? {
        object(for: 8)
    }

    /// 第十个元素
    var tenth: Util.Iterator.Element? {
        object(for: 9)
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

    /// 转换为 JSON String
    /// - Parameters:
    ///   - pretty: 是否格式对齐
    ///   - sort: 是否进行排序 > iOS 11
    /// - Returns: JSON 对应的 String
    func toJSONString(
        pretty: Bool = false,
        sort: Bool = false
    ) throws -> String? {
        String(data: try toData(pretty: pretty, sort: sort), encoding: .utf8)
    }

    func toJSONStringNotThrow(
        pretty: Bool = false,
        sort: Bool = false
    ) -> String? {
        try? toJSONString(pretty: pretty, sort: sort)
    }

    /// 转换为 Data 二进制
    /// - Parameter prettify: 是否对齐
    func toData(
        pretty: Bool = false,
        sort: Bool = false
    ) throws -> Data {
        guard JSONSerialization.isValidJSONObject(util) else {
            throw NSError(
                domain: "util.com.cn",
                code: -10000,
                userInfo: [NSLocalizedDescriptionKey: "非正确 JSON 格式"]
            )
        }
        var options: JSONSerialization.WritingOptions = []
        if pretty {
            options.insert(.prettyPrinted)
        }
        if #available(iOS 11, *) {
            if sort {
                options.insert(.sortedKeys)
            }
        }
        return try JSONSerialization.data(withJSONObject: util, options: options)
    }

    func toDataNotThrow() -> Data? {
        try? toData()
    }

    /// Codable 模型 反序列化
    /// - Parameter _: 集合包含的模型对象
    /// - Returns: 模型集合
    func toObject<T: Decodable>(_: T.Type) throws -> [T] {
        try JSONDecoder().decode([T].self, from: try toData())
    }

    func toObjectNotThrows<T: Decodable>(_: T.Type) -> [T]? {
        try? toObject(T.self)
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
    mutating func utilRemoveAll(_ item: Element) -> [Element] {
        removeAll(where: { $0 == item })
        return self
    }
}
