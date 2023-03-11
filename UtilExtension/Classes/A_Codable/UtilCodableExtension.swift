//
//  UtilCodableExtension.swift
//  UtilExtension
//
//  Created by 侯猛 on 2022/8/22.
//

import Foundation

public extension Encodable {
    /// 对 Codable 模型序列化操作
    /// 由于 Data 也遵循 Codable 协议, 所以 Data 也能调用此方法, 内部判断若是 Data 则返回 Data 本身
    func utilData() throws -> Data {
        if let data = self as? Data {
            return data
        }
        return try JSONEncoder().encode(self)
    }
}
