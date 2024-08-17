//
//  UtilStringExtension.swift
//  UtilExtension
//
//  Created by 侯猛 on 2022/8/6.
//

import Foundation

public extension UclortExtensionUtil where Util == String {
    /// 获取指定长度的随机字符串
    /// - Parameter length: 所需长度
    /// - Returns: 随机字符串
    static func random(ofLength length: Int) -> String {
        guard length > 0 else { return "" }
        let base = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var randomString = ""
        for _ in 1 ... length {
            randomString.append(base.randomElement()!)
        }
        return randomString
    }

    /// 尝试转换为 URL 类型
    var url: URL? {
        URL(string: util)
    }

    /// 将特殊字符进行编码
    var urlEncoded: String {
        var charSet = CharacterSet.urlQueryAllowed
        charSet.insert(charactersIn: "#")
        return util.addingPercentEncoding(withAllowedCharacters: charSet) ?? util
    }

    /// 将编码的特殊字符进行解码
    var urlDecoded: String {
        util.removingPercentEncoding ?? util
    }

    /// 非空字符串内容
    /// nil 和 "" 都返回 nil
    var notBlank: String? {
        util.isEmpty ? nil : util
    }

    /// 从开头截取字符串
    /// - Parameters:
    ///   - maxLength: 截取长度 不合规长度直接返回自身
    ///   - splice: 尾部拼接内容
    ///     - 如果需要截取拼接 splice 如果没有截取则忽略
    func prefix(
        _ maxLength: Int,
        splice: String = ""
    ) -> String {
        if maxLength >= util.count {
            return util
        }
        return "\(String(util.prefix(maxLength)))\(splice)"
    }

    /// 从开头截取字符串
    /// - Parameters:
    ///   - maxLength: 截取长度 不合规长度直接返回自身
    ///   - splice: 头部拼接内容
    ///     - 如果需要截取拼接 splice 如果没有截取则忽略
    func suffix(
        _ maxLength: Int,
        splice: String = ""
    ) -> String {
        if maxLength >= util.count {
            return util
        }
        return "\(splice)\(String(util.suffix(maxLength)))"
    }

    /// 获取目标字符串在文本中的 NSRange 位置对象
    /// - Parameter string: 目标字符串 不传或传 nil 返回整个字符串的位置对象
    /// - Returns: 目标字符的位置对象
    func range(of string: String? = nil) -> NSRange {
        nsString.range(of: string ?? util)
    }

    /// 替换字符串中的内容
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

    /// 删除指定字符
    func remove(of string: String) -> String {
        remove(of: [string])
    }

    /// 删除指定字符集合
    func remove(of strings: [String]) -> String {
        var result = util
        result.utilRemove(of: strings)
        return result
    }

    /// 字符集和
    var charactersArray: [Character] {
        Array(util)
    }

    /// 去除字符两端空白和换行
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
        guard let numberValue else { return nil }
        return CGFloat(numberValue.floatValue)
    }

    var timeIntervalValue: TimeInterval? {
        numberValue?.doubleValue
    }

    var boolValue: Bool {
        util == "true"
    }

    /// 转换颜色对象
    var asColor: UIColor {
        UIColor.util.hexString(util)
    }

    /// 字符串中是否包含 Emoji 字符
    ///
    ///		"Hello 😀".containEmoji -> true
    ///
    var containEmoji: Bool {
        // http://stackoverflow.com/questions/30757193/find-out-if-character-in-string-is-emoji
        for scalar in util.unicodeScalars {
            switch scalar.value {
            case 8400 ... 8447, // Combining Diacritical Marks for Symbols
                 9100 ... 9300, // Misc items
                 0x2600 ... 0x26FF, // Misc symbols
                 0x2700 ... 0x27BF, // Dingbats
                 0xFE00 ... 0xFE0F, // Variation Selectors
                 65024 ... 65039, // Variation selector
                 127000 ... 127600, // Various asian characters
                 0x1F1E6 ... 0x1F1FF, // Regional country flags
                 0x1F300 ... 0x1F5FF, // Misc Symbols and Pictographs
                 0x1F600 ... 0x1F64F, // Emoticons
                 0x1F680 ... 0x1F6FF, // Transport and Map
                 0x1F900 ... 0x1F9FF, // Supplemental Symbols and Pictographs
                 0xE0020 ... 0xE007F: // Tags
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
    ///		"SomeText".copyToPasteboard() // copies "SomeText" to pasteboard
    ///
    func copyToPasteboard() {
        UIPasteboard.general.string = util
    }

    /// 最后一个字符
    ///
    ///		"Hello".lastCharacterAsString -> Optional("o")
    ///		"".lastCharacterAsString -> nil
    ///
    var lastCharacterAsString: String? {
        guard let last = util.last else { return nil }
        return String(last)
    }

    /// 第一个字符
    ///
    ///		"Hello".firstCharacterAsString -> Optional("H")
    ///		"".firstCharacterAsString -> nil
    ///
    var firstCharacterAsString: String? {
        guard let first = util.first else { return nil }
        return String(first)
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

    /// 把字符串日期转换为日期对象
    /// - Parameter format: 默认 yyyy/MM/dd HH:mm:ss 格式
    func date(withFormat format: String = "yyyy/MM/dd HH:mm:ss") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "zh_GB")
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: util)
    }

    /// SwifterSwift: Check if string is a valid Swift number. Note: In North America, "." is the decimal separator, while in many parts of Europe "," is used,
    ///
    ///        "123".isNumeric -> true
    ///     "1.3".isNumeric -> true (en_US)
    ///     "1,3".isNumeric -> true (fr_FR)
    ///        "abc".isNumeric -> false
    ///
    var isNumeric: Bool {
        let scanner = Scanner(string: util)
        scanner.locale = NSLocale.current
        return scanner.scanDecimal(nil) && scanner.isAtEnd
    }

    /// 是否为手机号码
    var isPhoneNumber: Bool {
        if util.count != 11 {
            return false
        }
        // let pattern = "^(1[0-9])\\d{8}$"
        let pattern = "^(11[0-9]|13[0-9]|12[0-9]|14[0-9]|15[0-9]|16[0-9]|17[0-9]|18[0-9]|19[0-9]|10[0-9])\\d{8}$"
        let regex = try! NSRegularExpression(pattern: pattern, options: [])
        let result = regex.matches(in: util, options: [], range: NSRange(location: 0, length: util.count))

        if result.count > 0 {
            return true
        }

        return false
    }

    /// "" 判断
    /// - Parameter value: isEmpty 为 true 返回的值
    func empty(or value: String) -> String {
        util.isEmpty ? value : util
    }
}

// MARK: - NSString

public extension UclortExtensionUtil where Util == String {
    /// NSString from a string.
    var nsString: NSString {
        NSString(string: util)
    }

    /// NSString lastPathComponent.
    var lastPathComponent: String {
        (util as NSString).lastPathComponent
    }

    /// NSString pathExtension.
    var pathExtension: String {
        (util as NSString).pathExtension
    }

    /// NSString deletingLastPathComponent.
    var deletingLastPathComponent: String {
        (util as NSString).deletingLastPathComponent
    }

    /// NSString deletingPathExtension.
    var deletingPathExtension: String {
        (util as NSString).deletingPathExtension
    }

    /// NSString pathComponents.
    var pathComponents: [String] {
        (util as NSString).pathComponents
    }

    /// SwifterSwift: NSString appendingPathComponent(str: String)
    ///
    /// - Note: This method only works with file paths (not, for example, string representations of URLs.
    ///   See NSString [appendingPathComponent(_:)](https://developer.apple.com/documentation/foundation/nsstring/1417069-appendingpathcomponent)
    /// - Parameter str: the path component to append to the receiver.
    /// - Returns: a new string made by appending aString to the receiver, preceded if necessary by a path separator.
    func appendingPathComponent(_ str: String) -> String {
        (util as NSString).appendingPathComponent(str)
    }

    /// SwifterSwift: NSString appendingPathExtension(str: String)
    ///
    /// - Parameter str: The extension to append to the receiver.
    /// - Returns: a new string made by appending to the receiver an extension separator followed by ext (if applicable).
    func appendingPathExtension(_ str: String) -> String? {
        (util as NSString).appendingPathExtension(str)
    }
}

public extension UclortExtensionUtil where Util == String {
    /// 获取文本宽高
    /// - Parameters:
    ///   - attributes: 文本属性
    ///   - maxWidth: 最大宽
    ///   - maxHeight: 最大高
    /// - Returns: 文本尺寸
    func size(
        ofAttributes attributes: [NSAttributedString.Key: Any],
        maxWidth: CGFloat = CGFloat.greatestFiniteMagnitude,
        maxHeight: CGFloat = CGFloat.greatestFiniteMagnitude
    ) -> CGSize {
        let constraintRect = CGSize(width: maxWidth, height: maxHeight)
        let boundingRect = util.boundingRect(
            with: constraintRect,
            options: .usesLineFragmentOrigin,
            attributes: attributes,
            context: nil
        )
        return boundingRect.size
    }

    /// 获取文本高度
    /// - Parameters:
    ///   - font: 文本字体
    ///   - maxWidth: 最大宽
    /// - Returns: 文本高度
    func height(
        ofFont font: UIFont,
        maxWidth: CGFloat
    ) -> CGFloat {
        let constraintRect = CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude)
        let boundingRect = util.boundingRect(
            with: constraintRect,
            options: .usesLineFragmentOrigin,
            attributes: [.font: font],
            context: nil
        )
        return boundingRect.size.height
    }

    /// 获取文本宽度
    /// - Parameters:
    ///   - font: 文本字体
    ///   - maxHeight: 最大高
    /// - Returns: 文本宽度
    func width(
        ofFont font: UIFont,
        maxHeight: CGFloat
    ) -> CGFloat {
        let constraintRect = CGSize(width: CGFloat.greatestFiniteMagnitude, height: maxHeight)
        let boundingRect = util.boundingRect(
            with: constraintRect,
            options: .usesLineFragmentOrigin,
            attributes: [.font: font],
            context: nil
        )
        return boundingRect.size.width
    }

    /// 获取文本行数
    func lineNumber(
        ofFont font: UIFont,
        maxWidth: CGFloat
    ) -> Int {
        let text = NSAttributedString(string: util, attributes: [.font: font])
        return text.util.lineNumber(maxWidth: maxWidth)
    }
}

public extension String {
    /// 删除指定字符串
    /// - Parameter strings: 需要删除的字符串合集
    mutating func utilRemove(of string: String) {
        utilRemove(of: [string])
    }

    /// 删除指定字符串
    /// - Parameter strings: 需要删除的字符串合集
    mutating func utilRemove(of strings: [String]) {
        var string = self
        strings.forEach { string = string.replacingOccurrences(of: $0, with: "") }
        self = string
    }
}
