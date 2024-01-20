//
//  PKErrorExtension.swift
//  BaseExtension
//
//  Created by 侯猛 on 2023/1/7.
//

import Foundation

public extension UclortExtensionVariableUtil where Util == NSError {
    
    /// 创建 Error
    /// - Parameters:
    ///   - domain: 域名
    ///   - code: 状态码
    ///   - description: 本地化描述
    /// - Returns: Error
    static func createError(
        domain: String = "",
        code: Int,
        description: String = ""
    ) -> Error {
        createNSError(domain: domain, code: code, description: description)
    }
    
    /// 创建 NSError
    /// - Parameters:
    ///   - domain: 域名
    ///   - code: 状态码
    ///   - description: 本地化描述
    /// - Returns: NSError
    static func createNSError(
        domain: String = "",
        code: Int,
        description: String = ""
    ) -> NSError {
        NSError(domain: domain, code: code, userInfo: [NSLocalizedDescriptionKey: description])
    }
}
