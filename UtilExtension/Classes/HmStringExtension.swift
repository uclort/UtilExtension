//
//  HmStringExtension.swift
//  SwiftUtil
//
//  Created by mfhj-dz-001-059 on 2021/5/7.
//

import Foundation

public extension HmUtils where Util == String {
    // 将原始的url编码为合法的url
    func urlEncoded() -> String {
        util.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
    }
    
    // 将编码后的url转换回原始的url
    func urlDecoded() -> String {
        util.removingPercentEncoding ?? ""
    }
    
    /// 从开始截取字符串
    func prefix(_ maxLength: Int) -> String {
        if maxLength > util.count {
            return util
        }
        return String(util.prefix(maxLength))
    }
    
    /// 从结尾截取字符串
    func suffix(_ maxLength: Int) -> String {
        if maxLength > util.count {
            return util
        }
        return String(util.suffix(maxLength))
    }
    
    func range(of string: String = "") -> NSRange {
        let nsstring = util as NSString
        guard string.isEmpty == false else {
            return nsstring.range(of: util)
        }
        return nsstring.range(of: string)
    }
    
    // 替换字符串中的内容
    func replace(of: String, with: String) -> String {
        util.replacingOccurrences(of: of, with: with)
    }
    
    /// 解析 URL 获取 URL 所携带参数
    /// - Returns: URL 携带参数集合
    func getUrlParameter() -> [String: Any] {
        var parameters: [String: Any] = [:]
        guard let url = URL(string: util) else {
            return parameters
        }
        let components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        components?.queryItems?.forEach({ item in
            parameters[item.name] = item.value
        })
        return parameters
    }
    
    /// 本地化字符内容
    func localizedString(_ comment: String = "") -> String {
        NSLocalizedString(util, comment: comment)
    }
    
    /// 转成 Date
    func toDate(type: Date.DateFormatterType = .year_month_day) -> Date? {
        let dateFormatter = DateFormatter()
        var dateFormat = ""
        switch type {
        case .custom(let format):
            dateFormat = format
        default:
            dateFormat = type.rawValue
        }
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.date(from: util)
    }
    
    func toDateString(type: Date.DateFormatterType = .year_month_day) -> String? {
        timeIntervalValue?.util.toDateString(type: type)
    }
    
    func toDictionary() -> [String: Any]? {
        let data = util.data(using: .utf8)
        if let dict = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any] {
            return dict
        }
        return nil
    }
    
    /// 转成 NSNumber
    func toNumber() -> NSNumber? {
        NumberFormatter().number(from: util)
    }
    
    var intValue: Int? {
        toNumber()?.intValue
    }
    
    var int64Value: Int64? {
        toNumber()?.int64Value
    }
    
    var doubleValue: Double? {
        toNumber()?.doubleValue
    }
    
    var floatValue: Float? {
        toNumber()?.floatValue
    }
    
    var timeIntervalValue: TimeInterval? {
        toNumber()?.doubleValue
    }
    
    var boolValue: Bool {
        util == "true"
    }
}
