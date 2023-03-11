//
//  UtilDataExtension.swift
//  UtilExtension
//
//  Created by 侯猛 on 2022/8/22.
//

import Foundation

public extension UclortExtensionUtil where Util == Data {
    /// Codable 模型 反序列化
    /// - Parameter _: Codable 模型
    /// - Returns: 模型
    func toObject<T: Decodable>(_: T.Type) throws -> T {
        try JSONDecoder().decode(T.self, from: util)
    }

    /// 格式化为 Dictionary
    func toDictionary() throws -> [String: Any] {
        let JSONRaw = try JSONSerialization.jsonObject(with: util)
        if let JSONObject = JSONRaw as? [String: Any] {
            return JSONObject
        }
        throw NSError(
            domain: "util.com.cn",
            code: -10000,
            userInfo: [NSLocalizedDescriptionKey: "格式化失败，数据非 Dictionary 格式"]
        )
    }

    /// 格式化为 Array
    func toArray<T>(_: T.Type = [String: Any].self) throws -> [T] {
        let JSONRaw = try JSONSerialization.jsonObject(with: util)
        if let array = JSONRaw as? [T] {
            return array
        }
        throw NSError(
            domain: "util.com.cn",
            code: -10000,
            userInfo: [NSLocalizedDescriptionKey: "格式化失败，数据非 [\(T.self)] 格式"]
        )
    }
}
