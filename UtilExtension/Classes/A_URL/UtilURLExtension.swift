//
//  UtilURLExtension.swift
//  UtilExtension
//
//  Created by 侯猛 on 2022/8/6.
//

import Foundation

public extension UclortExtensionUtil where Util == URL {
    /// 附加查询参数
    /// - Parameter parameters: key value
    /// - Returns: 新的 URL
    func appendingQueryParameters(_ parameters: [String: String]) -> URL {
        guard var urlComponents = URLComponents(url: util, resolvingAgainstBaseURL: true) else { return util }
        var items = urlComponents.queryItems ?? []
        items += parameters.map { URLQueryItem(name: $0, value: $1) }
        urlComponents.queryItems = items
        return urlComponents.url!
    }
}
