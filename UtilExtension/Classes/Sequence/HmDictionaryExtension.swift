//
//  HmDictionaryExtension.swift
//  SwiftUtil
//
//  Created by mfhj-dz-001-059 on 2021/5/7.
//

import Foundation

public extension HmObjectUtils where Util: Sequence {
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
    
    func string(for key: String, defaultValue: String) -> String {
        string(for: key) ?? defaultValue
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
    
    func int(for key: String, defaultValue: Int) -> Int {
        int(for: key) ?? defaultValue
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
    
    func int64(for key: String, defaultValue: Int64) -> Int64 {
        int64(for: key) ?? defaultValue
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
    
    func double(for key: String, defaultValue: Double) -> Double {
        double(for: key) ?? defaultValue
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
    
    func float(for key: String, defaultValue: Float) -> Float {
        float(for: key) ?? defaultValue
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
    
    func bool(for key: String, defaultValue: Bool) -> Bool {
        bool(for: key) ?? defaultValue
    }
    
    /// 获取 key 对应的 value 并尝试转换为字典
    func object(for key: String) -> [String: Any]? {
        guard let util = util as? [String: Any] else { return nil }
        return util[key] as? [String: Any]
    }
    
    func object(for key: String, defaultValue: [String: Any]) -> [String: Any] {
        object(for: key) ?? defaultValue
    }
    
    /// 合并两个字典
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
    ///   - sort: 是否进行排序
    /// - Returns: JSON 对应的 String
    func toJsonString(pretty: Bool = false, sort: Bool = false) -> String? {
        var options: JSONSerialization.WritingOptions = []
        if pretty {
            options.insert(.prettyPrinted)
        }
        if #available(iOS 11, *) {
            if sort {
                options.insert(.sortedKeys)
            }
        }
        guard JSONSerialization.isValidJSONObject(util), let data = try? JSONSerialization.data(withJSONObject: util, options: options) else {
            return nil
        }
        return String(data: data, encoding: String.Encoding.utf8)
    }
    
    /// 转换为 Data 二进制
    /// - Parameter prettify: 是否对齐
    func toJsonData(prettify: Bool = false) -> Data? {
        guard JSONSerialization.isValidJSONObject(util) else {
            return nil
        }
        let options = (prettify == true) ? JSONSerialization.WritingOptions.prettyPrinted : JSONSerialization.WritingOptions()
        return try? JSONSerialization.data(withJSONObject: util, options: options)
    }
    
    /// 是否包含某个 Key
    func has(key: String) -> Bool {
        guard let util = util as? [String: Any] else { return false }
        return util.index(forKey: key) != nil
    }
}
