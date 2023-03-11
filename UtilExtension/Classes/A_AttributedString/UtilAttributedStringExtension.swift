//
//  UtilAttributedStringExtension.swift
//  UtilExtension
//
//  Created by 侯猛 on 2022/8/6.
//

import Foundation

public extension UclortExtensionVariableUtil where Util: NSAttributedString {
    /// 合并富文本
    /// - Parameter rhs: 要合并的富文本
    /// - Returns: 合并后的富文本
    func merge(rhs: NSAttributedString) -> NSAttributedString {
        let string = NSMutableAttributedString(attributedString: util)
        string.append(rhs)
        return NSAttributedString(attributedString: string)
    }
}

public protocol UtilURLStringGeneral {
    func asURL() -> URL?
}

extension URL: UtilURLStringGeneral {
    public func asURL() -> URL? {
        self
    }
}

extension String: UtilURLStringGeneral {
    public func asURL() -> URL? {
        URL(string: self)
    }
}

public protocol PKAttributedStringType {
    func strings() -> [String]
}

extension Array: PKAttributedStringType where Element == String {
    public func strings() -> [String] {
        self
    }
}

extension String: PKAttributedStringType {
    public func strings() -> [String] {
        [self]
    }
}

public enum UtilAttributedStringKey {
    /// 文字字体
    case font(_ value: UIFont, string: PKAttributedStringType? = nil)
    /// 段落设置属性(可设置行间距)
    case paragraphStyle(_ value: NSParagraphStyle, string: PKAttributedStringType? = nil)
    /// 文字颜色
    case foregroundColor(_ value: UIColor, string: PKAttributedStringType? = nil)
    /// 文字背景颜色
    case backgroundColor(_ value: UIColor, string: PKAttributedStringType? = nil)
    /// 字符间隔
    case kern(_ value: CGFloat, string: PKAttributedStringType? = nil)
    /// 删除线
    /// .single: 画一条线。
    /// .thick: 画一条粗线。
    /// .double: 画一条双线。
    /// .patternDot: 画一条点线。
    /// .patternDash: 画一条虚线。
    /// .patternDashDot: 面一条交替的虛线和点线。
    /// .patternDashDotDot: 画一条由交替的破折号和两个点组成的线。
    /// .byWork: 只在字的下面或通过字画线，而不是在空白处画线。
    case strikethroughStyle(_ value: NSUnderlineStyle, string: PKAttributedStringType? = nil)
    /// 删除线颜色
    case strikethroughColor(_ value: UIColor, string: PKAttributedStringType? = nil)
    /// 下划线
    /// .single: 画一条线。
    /// .thick: 画一条粗线。
    /// .double: 画一条双线。
    /// .patternDot: 画一条点线。
    /// .patternDash: 画一条虚线。
    /// .patternDashDot: 面一条交替的虛线和点线。
    /// .patternDashDotDot: 画一条由交替的破折号和两个点组成的线。
    /// .byWork: 只在字的下面或通过字画线，而不是在空白处画线。
    case underlineStyle(_ value: NSUnderlineStyle, string: PKAttributedStringType? = nil)
    /// 下划线颜色
    case underlineColor(_ value: UIColor, string: PKAttributedStringType? = nil)
    /// 文本描边宽度
    case strokeWidth(_ value: CGFloat, string: PKAttributedStringType? = nil)
    /// 文本描边颜色
    case strokeColor(_ value: UIColor, string: PKAttributedStringType? = nil)
    /// 阴影
    /// shadowOffset: 阴影偏移量
    /// shadowBlurRadius: 阴影半径
    /// shadowColor: 阴影颜色
    case shadow(_ value: NSShadow, string: PKAttributedStringType? = nil)
    /// 文本链接 String or URL
    case link(_ value: UtilURLStringGeneral, string: PKAttributedStringType? = nil)
    /// 基础偏移量 < 0 向下偏移; > 0 向上偏移;
    case baselineOffset(_ value: CGFloat, string: PKAttributedStringType? = nil)
    /// 字体倾斜
    case obliqueness(_ value: CGFloat, string: PKAttributedStringType? = nil)
    /// 字体扁平化
    case expansion(_ value: Int, string: PKAttributedStringType? = nil)
    /// 插入图片
    /// bounds 图片位置和尺寸
    /// index 图片所在位置 默认 -1 直接在末尾 add
    case image(image: UIImage?, bounds: CGRect, index: Int = -1)
}

public extension UclortExtensionVariableUtil where Util: NSMutableAttributedString {
    /// 添加富文本样式
    ///
    /// 此方法只会对 string 参数进行富文本样式添加
    /// 单独类型的 string 将被忽略
    /// 若需要单独类型设置 请使用 func addAttribute(_ keys: [UtilAttributedStringKey]) 方法
    ///
    /// - Parameters:
    ///   - keys: 富文本类型
    ///   - string: 富文本生效字符
    func addAttribute(
        _ keys: [UtilAttributedStringKey],
        of string: PKAttributedStringType
    ) {
        keys.forEach {
            var key: NSAttributedString.Key?
            var value: Any?
            switch $0 {
            case let .font(v, _):
                key = .font
                value = v
            case let .paragraphStyle(v, _):
                key = .paragraphStyle
                value = v
            case let .foregroundColor(v, _):
                key = .foregroundColor
                value = v
            case let .backgroundColor(v, _):
                key = .backgroundColor
                value = v
            case let .kern(v, _):
                key = .kern
                value = v
            case let .strikethroughStyle(v, _):
                key = .strikethroughStyle
                value = v.rawValue
            case let .strikethroughColor(v, _):
                key = .strikethroughColor
                value = v
            case let .underlineStyle(v, _):
                key = .underlineStyle
                value = v.rawValue
            case let .underlineColor(v, _):
                key = .underlineColor
                value = v
            case let .strokeColor(v, _):
                key = .strokeColor
                value = v
            case let .strokeWidth(v, _):
                key = .strokeWidth
                value = v
            case let .shadow(v, _):
                key = .shadow
                value = v
            case let .link(v, _):
                key = .link
                value = v
            case let .baselineOffset(v, _):
                key = .baselineOffset
                value = v
            case let .obliqueness(v, _):
                key = .obliqueness
                value = v
            case let .expansion(v, _):
                key = .expansion
                value = v
            case let .image(image, bounds, index):
                let attachment = NSTextAttachment()
                attachment.image = image
                attachment.bounds = bounds
                let imageAttributedString = NSAttributedString(attachment: attachment)
                if index == -1 {
                    util.append(imageAttributedString)
                } else {
                    util.insert(imageAttributedString, at: index)
                }
            }
            guard let key, let value else { return }
            var strings = string.strings()
            if strings.isEmpty {
                strings = [util.string]
            }
            strings.forEach { string in
                util.addAttribute(
                    key,
                    value: value,
                    range: range(of: string)
                )
            }
        }
    }

    /// 添加富文本样式
    ///
    /// 此方法只会对每个类型中的单独 string 进行富文本样式设置
    /// 如果类型中的 string 传 nil 或不传保持默认 将对整个字符串生效
    /// !!!请注意类型集合的优先级后添加的会覆盖前添加的
    ///
    /// - Parameters:
    ///   - keys: 富文本类型
    func addAttribute(_ keys: [UtilAttributedStringKey]) {
        keys.forEach {
            var key: NSAttributedString.Key?
            var value: Any?
            var stringType: PKAttributedStringType?
            switch $0 {
            case let .font(v, s):
                key = .font
                value = v
                stringType = s
            case let .paragraphStyle(v, s):
                key = .paragraphStyle
                value = v
                stringType = s
            case let .foregroundColor(v, s):
                key = .foregroundColor
                value = v
                stringType = s
            case let .backgroundColor(v, s):
                key = .backgroundColor
                value = v
                stringType = s
            case let .kern(v, s):
                key = .kern
                value = v
                stringType = s
            case let .strikethroughStyle(v, s):
                key = .strikethroughStyle
                value = v.rawValue
                stringType = s
            case let .strikethroughColor(v, s):
                key = .strikethroughColor
                value = v
                stringType = s
            case let .underlineStyle(v, s):
                key = .underlineStyle
                value = v.rawValue
                stringType = s
            case let .underlineColor(v, s):
                key = .underlineColor
                value = v
                stringType = s
            case let .strokeColor(v, s):
                key = .strokeColor
                value = v
                stringType = s
            case let .strokeWidth(v, s):
                key = .strokeWidth
                value = v
                stringType = s
            case let .shadow(v, s):
                key = .shadow
                value = v
                stringType = s
            case let .link(v, s):
                key = .link
                value = v
                stringType = s
            case let .baselineOffset(v, s):
                key = .baselineOffset
                value = v
                stringType = s
            case let .obliqueness(v, s):
                key = .obliqueness
                value = v
                stringType = s
            case let .expansion(v, s):
                key = .expansion
                value = v
                stringType = s
            case let .image(image, bounds, index):
                let attachment = NSTextAttachment()
                attachment.image = image
                attachment.bounds = bounds
                let imageAttributedString = NSAttributedString(attachment: attachment)
                if index == -1 {
                    util.append(imageAttributedString)
                } else {
                    util.insert(imageAttributedString, at: index)
                }
            }
            guard let key, let value else { return }
            let strings = stringType?.strings() ?? [util.string]
            strings.forEach { string in
                util.addAttribute(
                    key,
                    value: value,
                    range: range(of: string)
                )
            }
        }
    }

    /// 获取目标字符串在富文本中的 NSRange 位置对象
    /// - Parameter string: 目标字符串 不传或传 nil 返回整个字符串的位置对象
    /// - Returns: NSRange 目标字符的位置对象
    func range(of string: String? = nil) -> NSRange {
        util.string.util.range(of: string ?? util.string)
    }
}

public extension UclortExtensionVariableUtil where Util: NSAttributedString {
    /// 获取文本宽高
    /// - Parameters:
    ///   - maxWidth: 最大宽
    ///   - maxHeight: 最大高
    /// - Returns: 文本尺寸
    func size(
        maxWidth: CGFloat = CGFloat.greatestFiniteMagnitude,
        maxHeight: CGFloat = CGFloat.greatestFiniteMagnitude
    ) -> CGSize {
        let constraintRect = CGSize(width: maxWidth, height: maxHeight)
        let boundingRect = util.boundingRect(
            with: constraintRect,
            options: .usesLineFragmentOrigin,
            context: nil
        )
        return boundingRect.size
    }

    /// 获取文本高度
    /// - Parameters:
    ///   - maxWidth: 最大宽
    /// - Returns: 文本高度
    func height(
        maxWidth: CGFloat
    ) -> CGFloat {
        let constraintRect = CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude)
        let boundingRect = util.boundingRect(
            with: constraintRect,
            options: .usesLineFragmentOrigin,
            context: nil
        )
        return boundingRect.size.height
    }

    /// 获取文本宽度
    /// - Parameters:
    ///   - maxHeight: 最大高
    /// - Returns: 文本宽度
    func width(
        maxHeight: CGFloat
    ) -> CGFloat {
        let constraintRect = CGSize(width: CGFloat.greatestFiniteMagnitude, height: maxHeight)
        let boundingRect = util.boundingRect(
            with: constraintRect,
            options: .usesLineFragmentOrigin,
            context: nil
        )
        return boundingRect.size.width
    }

    /// 获取文本行数
    func lineNumber(
        maxWidth: CGFloat
    ) -> Int {
        let attributedString = util as NSAttributedString
        let framesetter = CTFramesetterCreateWithAttributedString(attributedString)
        let aPath = CGMutablePath()
        aPath.addRect(CGRect(x: 0, y: 0, width: maxWidth, height: CGFloat(Int32.max)), transform: .identity)
        let frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(CFIndex(0), CFIndex(0)), aPath, nil)
        let rows = CTFrameGetLines(frame)
        let numberOfLines = CFArrayGetCount(rows)
        return numberOfLines
    }
}
