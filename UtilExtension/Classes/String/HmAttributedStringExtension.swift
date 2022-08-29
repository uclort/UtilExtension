//
//  HmAttributedStringExtension.swift
//  SwiftUtil
//
//  Created by mfhj-dz-001-059 on 2021/5/7.
//

#if os(iOS)
import UIKit

public protocol URLStringGeneral {
    func asURL() -> URL?
}

extension URL: URLStringGeneral {
    public func asURL() -> URL? {
        self
    }
}

extension String: URLStringGeneral {
    public func asURL() -> URL? {
        URL(string: self)
    }
}

public enum HmAttributedStringKey {
    /// 文字字体
    case font(UIFont)
    /// 段落设置属性
    case paragraphStyle(NSParagraphStyle)
    /// 文字颜色
    case foregroundColor(UIColor)
    /// 文字背景颜色
    case backgroundColor(UIColor)
    /// 字符间隔
    case kern(CGFloat)
    /// 删除线
    case strikethroughStyle(Int)
    /// 删除线颜色
    case strikethroughColor(UIColor)
    /// 下划线
    case underlineStyle(Int)
    /// 下划线颜色
    case underlineColor(UIColor)
    /// 文本描边宽度
    case strokeWidth(CGFloat)
    /// 文本描边颜色
    case strokeColor(UIColor)
    /// 阴影
    case shadow(NSShadow)
    /// 文本链接
    case link(URLStringGeneral)
    /// 基础偏移量 < 0 向下偏移; > 0 向上偏移;
    case baselineOffset(CGFloat)
    /// 字体倾斜
    case obliqueness(CGFloat)
    /// 字体扁平化
    case expansion(Int)
}

public extension HmUtils where Util: NSMutableAttributedString {
    func addAttribute(_ keys: [HmAttributedStringKey], rangeString: String = "") {
        keys.forEach {
            let key: NSAttributedString.Key
            let value: Any
            switch $0 {
            case .font(let v):
                key = .font
                value = v
            case .paragraphStyle(let v):
                key = .paragraphStyle
                value = v
            case .foregroundColor(let v):
                key = .foregroundColor
                value = v
            case .backgroundColor(let v):
                key = .backgroundColor
                value = v
            case .kern(let v):
                key = .kern
                value = v
            case .strikethroughStyle(let v):
                key = .strikethroughStyle
                value = v
            case .strikethroughColor(let v):
                key = .strikethroughColor
                value = v
            case .underlineStyle(let v):
                key = .underlineStyle
                value = v
            case .underlineColor(let v):
                key = .underlineColor
                value = v
            case .strokeColor(let v):
                key = .strokeColor
                value = v
            case .strokeWidth(let v):
                key = .strokeWidth
                value = v
            case .shadow(let v):
                key = .shadow
                value = v
            case .link(let v):
                key = .link
                value = v
            case .baselineOffset(let v):
                key = .baselineOffset
                value = v
            case .obliqueness(let v):
                key = .obliqueness
                value = v
            case .expansion(let v):
                key = .expansion
                value = v
            }
            util.addAttribute(
                key,
                value: value,
                range: range(of: rangeString)
            )
        }
    }

    func range(of string: String = "") -> NSRange {
        util.string.util.range(of: string)
    }
}
#endif
