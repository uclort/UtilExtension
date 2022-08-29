//
//  HmStringExtension.swift
//  SwiftUtil
//
//  Created by mfhj-dz-001-059 on 2021/5/7.
//

import Foundation

public extension HmUtils where Util == String {
    /// 获取指定长度的随机字符串
    /// - Parameter length: <#length description#>
    /// - Returns: <#description#>
    static func random(ofLength length: Int) -> String {
        guard length > 0 else { return "" }
        let base = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var randomString = ""
        for _ in 1...length {
            randomString.append(base.randomElement()!)
        }
        return randomString
    }

    /// 尝试转换为 URL 类型
    var url: URL? {
        URL(string: util)
    }

    // 将特殊字符进行编码
    var urlEncoded: String {
        util.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? util
    }

    // 将编码的特殊字符进行解码
    var urlDecoded: String {
        util.removingPercentEncoding ?? util
    }

    /// 从头截取指定长度的字符串
    func prefix(_ maxLength: Int) -> String {
        if maxLength > util.count {
            return util
        }
        return String(util.prefix(maxLength))
    }

    /// 从尾截取指定长度的字符串
    func suffix(_ maxLength: Int) -> String {
        if maxLength > util.count {
            return util
        }
        return String(util.suffix(maxLength))
    }

    /// 获取指定文字对应的 NSRange
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
    var urlParameter: [String: String] {
        var parameters: [String: String] = [:]
        guard let url = URL(string: util) else {
            return parameters
        }
        let components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        components?.queryItems?.forEach { item in
            parameters[item.name] = item.value
        }
        return parameters
    }

    /// 本地化字符内容
    func localizedString(_ comment: String = "") -> String {
        NSLocalizedString(util, comment: comment)
    }

    /// 尝试转成对象
    var toObject: [String: Any]? {
        let data = util.data(using: .utf8)
        if let dict = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any] {
            return dict
        }
        return nil
    }

    /// 删除指定的前缀
    ///
    ///   "Hello, World!".removingPrefix("Hello, ") -> "World!"
    ///
    /// - Parameter prefix: Prefix to remove from the string.
    /// - Returns: The string after prefix removing.
    func removingPrefix(_ prefix: String) -> String {
        guard util.hasPrefix(prefix) else { return util }
        return String(util.dropFirst(prefix.count))
    }

    /// 删除指定的后缀
    ///
    ///   "Hello, World!".removingSuffix(", World!") -> "Hello"
    ///
    /// - Parameter suffix: Suffix to remove from the string.
    /// - Returns: The string after suffix removing.
    func removingSuffix(_ suffix: String) -> String {
        guard util.hasSuffix(suffix) else { return util }
        return String(util.dropLast(suffix.count))
    }

    /// 给字符串添加前缀
    ///
    ///     "www.apple.com".withPrefix("https://") -> "https://www.apple.com"
    ///
    /// - Parameter prefix: Prefix to add to the string.
    /// - Returns: The string with the prefix prepended.
    func withPrefix(_ prefix: String) -> String {
        // https://www.hackingwithswift.com/articles/141/8-useful-swift-extensions
        guard !util.hasPrefix(prefix) else { return util }
        return prefix + util
    }

    /// 字符集和
    var charactersArray: [Character] {
        Array(util)
    }

    /// 去除字符两端空白
    var trimmed: String {
        util.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    /// 转成 NSNumber
    var numberValue: NSNumber? {
        NumberFormatter().number(from: util)
    }

    var intValue: Int? {
        numberValue?.intValue
    }

    var int64Value: Int64? {
        numberValue?.int64Value
    }

    var doubleValue: Double? {
        numberValue?.doubleValue
    }

    var floatValue: Float? {
        numberValue?.floatValue
    }

    var cgFloatValue: CGFloat? {
        guard let numberValue = numberValue else { return nil }
        return CGFloat(numberValue.floatValue)
    }

    var timeIntervalValue: TimeInterval? {
        numberValue?.doubleValue
    }

    var boolValue: Bool {
        util == "true"
    }

    /// 字符串中是否包含 Emoji 字符
    ///
    ///        "Hello 😀".containEmoji -> true
    ///
    var containEmoji: Bool {
        // http://stackoverflow.com/questions/30757193/find-out-if-character-in-string-is-emoji
        for scalar in util.unicodeScalars {
            switch scalar.value {
            case 0x1F600...0x1F64F, // Emoticons
                 0x1F300...0x1F5FF, // Misc Symbols and Pictographs
                 0x1F680...0x1F6FF, // Transport and Map
                 0x1F1E6...0x1F1FF, // Regional country flags
                 0x2600...0x26FF, // Misc symbols
                 0x2700...0x27BF, // Dingbats
                 0xE0020...0xE007F, // Tags
                 0xFE00...0xFE0F, // Variation Selectors
                 0x1F900...0x1F9FF, // Supplemental Symbols and Pictographs
                 127000...127600, // Various asian characters
                 65024...65039, // Variation selector
                 9100...9300, // Misc items
                 8400...8447: // Combining Diacritical Marks for Symbols
                return true
            default:
                continue
            }
        }
        return false
    }

    /// 获取指定位置的字符
    /// - Parameter index: 指定位置
    /// - Returns: 指定位置的字符
    func character(for index: Int) -> Character? {
        guard index >= 0, index < util.count else { return nil }
        return util[util.index(util.startIndex, offsetBy: index)]
    }

    /// 复制到剪贴板
    ///
    ///        "SomeText".copyToPasteboard() // copies "SomeText" to pasteboard
    ///
    #if os(iOS) || os(macOS)
    func copyToPasteboard() {
        #if os(iOS)
        UIPasteboard.general.string = util
        #elseif os(macOS)
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString(util, forType: .string)
        #endif
    }
    #endif

    /// 最后一个字符
    ///
    ///        "Hello".lastCharacterAsString -> Optional("o")
    ///        "".lastCharacterAsString -> nil
    ///
    var lastCharacterAsString: String? {
        guard let last = util.last else { return nil }
        return String(last)
    }

    /// 第一个字符
    ///
    ///        "Hello".firstCharacterAsString -> Optional("H")
    ///        "".firstCharacterAsString -> nil
    ///
    var firstCharacterAsString: String? {
        guard let first = util.first else { return nil }
        return String(first)
    }

    /// 转换为时间对象
    /// 需要格式为 yyyy-MM-dd HH:mm:ss
    var dateTime: Date? {
        let selfLowercased = util.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.date(from: selfLowercased)
    }

    /// 是否包含指定字符串
    /// - Parameters:
    ///   - string: 判断是否包含的指定字符串
    ///   - caseSensitive: 是否区分大小写
    func contains(_ string: String, caseSensitive: Bool = true) -> Bool {
        if !caseSensitive {
            return util.range(of: string, options: .caseInsensitive) != nil
        }
        return util.range(of: string) != nil
    }

    var date: Date? {
        let selfLowercased = util.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: selfLowercased)
    }

    /// SwifterSwift: Date object from string of date format.
    ///
    ///        "2017-01-15".date(withFormat: "yyyy-MM-dd") -> Date set to Jan 15, 2017
    ///        "not date string".date(withFormat: "yyyy-MM-dd") -> nil
    ///
    /// - Parameter format: date format.
    /// - Returns: Date object from string (if applicable).
    func date(withFormat format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: util)
    }
}

// MARK: - NSString

public extension HmUtils where Util == String {
    /// NSString from a string.
    var nsString: NSString {
        return NSString(string: util)
    }

    /// NSString lastPathComponent.
    var lastPathComponent: String {
        return (util as NSString).lastPathComponent
    }

    /// NSString pathExtension.
    var pathExtension: String {
        return (util as NSString).pathExtension
    }

    /// NSString deletingLastPathComponent.
    var deletingLastPathComponent: String {
        return (util as NSString).deletingLastPathComponent
    }

    /// NSString deletingPathExtension.
    var deletingPathExtension: String {
        return (util as NSString).deletingPathExtension
    }

    /// NSString pathComponents.
    var pathComponents: [String] {
        return (util as NSString).pathComponents
    }

    /// SwifterSwift: NSString appendingPathComponent(str: String)
    ///
    /// - Note: This method only works with file paths (not, for example, string representations of URLs.
    ///   See NSString [appendingPathComponent(_:)](https://developer.apple.com/documentation/foundation/nsstring/1417069-appendingpathcomponent)
    /// - Parameter str: the path component to append to the receiver.
    /// - Returns: a new string made by appending aString to the receiver, preceded if necessary by a path separator.
    func appendingPathComponent(_ str: String) -> String {
        return (util as NSString).appendingPathComponent(str)
    }

    /// SwifterSwift: NSString appendingPathExtension(str: String)
    ///
    /// - Parameter str: The extension to append to the receiver.
    /// - Returns: a new string made by appending to the receiver an extension separator followed by ext (if applicable).
    func appendingPathExtension(_ str: String) -> String? {
        return (util as NSString).appendingPathExtension(str)
    }
}
