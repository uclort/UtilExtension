//
//  UtilDictionaryExtension.swift
//  UtilExtension
//
//  Created by 侯猛 on 2022/8/6.
//

import Foundation

public extension UclortExtensionDictionaryUtil where Util: Sequence {
    /// 获取 key 对应的 value 并尝试转换为 String
    func string(for key: String) -> String? {
        guard let util = util as? [String: Any] else { return nil }
        let value = util[key]
        if let valueString = value as? String {
            return valueString
        } else if let valueInt64 = value as? Int64 { // 是整型
            return valueInt64.util.stringValue
        } else if let valueInt = value as? Int { // 是整型
            return valueInt.util.stringValue
        } else if let valueDouble = value as? Double { // 是浮点型
            return valueDouble.util.stringValue
        } else if let valueFloat = value as? Float { // 是浮点型
            return valueFloat.util.stringValue
        }
        return nil
    }

    /// 获取 key 对应的 value 并尝试转换为 Int
    func int(for key: String) -> Int? {
        guard let util = util as? [String: Any] else { return nil }
        let value = util[key]
        if let valueInt = value as? Int { // 是整型
            return valueInt
        } else if let valueInt64 = value as? Int64 { // 是浮点型
            return valueInt64.util.intValue
        } else if let valueDouble = value as? Double { // 是浮点型
            return valueDouble.util.intValue
        } else if let valueFloat = value as? Float { // 是浮点型
            return valueFloat.util.intValue
        } else if let valueString = value as? String {
            return valueString.util.intValue
        }
        return nil
    }

    /// 获取 key 对应的 value 并尝试转换为 Int64
    func int64(for key: String) -> Int64? {
        guard let util = util as? [String: Any] else { return nil }
        let value = util[key]
        if let valueInt64 = value as? Int64 { // 是整型
            return valueInt64
        } else if let valueInt = value as? Int { // 是浮点型
            return valueInt.util.int64Value
        } else if let valueDouble = value as? Double { // 是浮点型
            return valueDouble.util.int64Value
        } else if let valueFloat = value as? Float { // 是浮点型
            return valueFloat.util.int64Value
        } else if let valueString = value as? String {
            return valueString.util.int64Value
        }
        return nil
    }

    /// 获取 key 对应的 value 并尝试转换为 Double
    func double(for key: String) -> Double? {
        guard let util = util as? [String: Any] else { return nil }
        let value = util[key]
        if let valueDouble = value as? Double { // 是浮点型
            return valueDouble
        } else if let valueFloat = value as? Float { // 是整型
            return valueFloat.util.doubleValue
        } else if let valueInt = value as? Int { // 是整型
            return valueInt.util.doubleValue
        } else if let valueInt64 = value as? Int64 { // 是整型
            return valueInt64.util.doubleValue
        } else if let valueString = value as? String {
            return valueString.util.doubleValue
        }
        return nil
    }

    /// 获取 key 对应的 value 并尝试转换为 Float
    func float(for key: String) -> Float? {
        guard let util = util as? [String: Any] else { return nil }
        let value = util[key]
        if let valueFloat = value as? Float { // 是整型
            return valueFloat
        } else if let valueDouble = value as? Double { // 是浮点型
            return valueDouble.util.floatValue
        } else if let valueInt = value as? Int { // 是整型
            return valueInt.util.floatValue
        } else if let valueInt64 = value as? Int64 { // 是整型
            return valueInt64.util.floatValue
        } else if let valueString = value as? String {
            return valueString.util.floatValue
        }
        return nil
    }

    /// 获取 key 对应的 value 并尝试转换为 Bool
    func bool(for key: String) -> Bool? {
        guard let util = util as? [String: Any] else { return nil }
        let value = util[key]
        if let valueBool = value as? Bool { // 是整型
            return valueBool
        } else if let valueInt = value as? Int { // 是整型
            return valueInt > 0
        } else if let valueString = value as? String {
            return valueString.util.boolValue
        }
        return nil
    }

    /// 获取 key 对应的 value 并尝试转换为字典
    func object(for key: String) -> [String: Any]? {
        guard let util = util as? [String: Any] else { return nil }
        return util[key] as? [String: Any]
    }

    /// 获取 key 对应的 value 并尝试转换为 T 泛型
    func objectValue<T>(for key: String, _: T.Type) -> T? {
        guard let util = util as? [String: Any] else { return nil }
        return util[key] as? T
    }

    /// 获取 key 对应的 value 并尝试转换为字典集合
    func objects(for key: String) -> [[String: Any]]? {
        guard let util = util as? [String: Any] else { return nil }
        return util[key] as? [[String: Any]]
    }

    /// 是否包含某个 Key
    func has(key: String) -> Bool {
        guard let util = util as? [String: Any] else { return false }
        return util.index(forKey: key) != nil
    }

    /// 合并两个对象
    /// - Parameter otherDictionary: 需要并入的对象 相同 Key 以 otherDictionary 优先
    /// - Returns: 包含两个对象所有 key value 的新对象
    func merge(_ otherDictionary: [String: Any]?) -> [String: Any] {
        guard let util = util as? [String: Any] else { return [:] }
        guard let otherDictionary = otherDictionary else {
            return util
        }
        var newDictionary: [String: Any] = [:]
        for item in util {
            newDictionary[item.key] = item.value
        }
        for item in otherDictionary {
            newDictionary[item.key] = item.value
        }
        return newDictionary
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
    /// - Parameter _: Codable 模型
    /// - Returns: 模型
    func toObject<T: Decodable>(_: T.Type) throws -> T {
        try JSONDecoder().decode(T.self, from: try toData())
    }

    func toObjectNotThrows<T: Decodable>(_: T.Type) -> T? {
        try? toObject(T.self)
    }

    /// 未知, 项目中部分使用, 当做兼容
    func compactMapKeysAndValues<K, V>(_ transform: ((key: String, value: Any)) -> (K, V)?) -> [K: V] {
        guard let util = util as? [String: Any] else { return [:] }
        return [K: V](uniqueKeysWithValues: util.compactMap(transform))
    }
}

public extension Dictionary {
    /// 合并两个字典
    /// 相同 key 以传入的字典为准
    mutating func utilMerge(_ otherDictionary: Dictionary?) {
        guard let otherDictionary = otherDictionary else {
            return
        }
        otherDictionary.forEach { key, value in
            self[key] = value
        }
    }

    /// 修改 key
    /// - Parameters:
    ///   - fromKey: 原 key
    ///   - toKey: 要修改成的 key
    mutating func utilModifyKey(original key: Key, new newKey: Key) {
        guard key != newKey else { return }
        if let entry = removeValue(forKey: newKey) {
            self[newKey] = entry
        }
    }
    
    /// 删除字典中包含的 keys 集合中的键值对
    /// - Parameter keys: 需要删除的 key 集合
    mutating func utilRemoveAll(forKeys keys: [Key]) {
        keys.forEach { key in
            guard self.keys.contains(key) else { return }
            self.removeValue(forKey: key)
        }
    }
}
