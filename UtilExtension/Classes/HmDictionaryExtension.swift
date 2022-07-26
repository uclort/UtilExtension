//
//  HmDictionaryExtension.swift
//  SwiftUtil
//
//  Created by mfhj-dz-001-059 on 2021/5/7.
//

import Foundation

public extension HmUtils where Util == [String: Any] {
    func string(for key: String) -> String? {
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
    
    func int(for key: String) -> Int? {
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
    
    func int64(for key: String) -> Int64? {
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
    
    func double(for key: String) -> Double? {
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
    
    func float(for key: String) -> Float? {
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
    
    func bool(for key: String) -> Bool? {
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
    
    func dictionary(for key: String) -> [String: Any]? {
        util[key] as? [String: Any]
    }
    
    func merge(_ otherDictionary: [String: Any]?) -> [String: Any] {
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
    
    func toJsonString(pretty: Bool = true, sort: Bool = false) -> String? {
        var options: JSONSerialization.WritingOptions = []
        if pretty {
            options.insert(.prettyPrinted)
        }
        if sort {
            options.insert(.sortedKeys)
        }
        guard JSONSerialization.isValidJSONObject(util), let data = try? JSONSerialization.data(withJSONObject: util, options: options) else {
            return nil
        }
        return String(data: data, encoding: String.Encoding.utf8)
    }
}
