//
//  HmAttributedStringExtension.swift
//  SwiftUtil
//
//  Created by mfhj-dz-001-059 on 2021/5/7.
//

#if os(iOS)
import UIKit

public enum HmAttributedStringKey {
    /// 文字字体
    case font(UIFont)
    /// 文字颜色
    case foregroundColor(UIColor)
}

public extension HmUtils where Util == NSMutableAttributedString {
    func addAttribute(_ keys: HmAttributedStringKey..., rangeString: String = "") {
        keys.forEach { key in
            switch key {
            case .font(let value):
                util.addAttribute(
                    .font,
                    value: value,
                    range: range(of: rangeString)
                )
            case .foregroundColor(let value):
                util.addAttribute(
                    .foregroundColor,
                    value: value,
                    range: range(of: rangeString)
                )
            }
        }
    }

    func range(of string: String = "") -> NSRange {
        util.string.util.range(of: string)
    }
}
#endif
