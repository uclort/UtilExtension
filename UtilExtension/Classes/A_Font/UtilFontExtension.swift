//
//  UtilFontExtension.swift
//  UtilExtension
//
//  Created by 侯猛 on 2022/8/10.
//

import Foundation

public extension UclortExtensionVariableUtil where Util == UIFont {
    /// SwifterSwift: Font as bold font
    var bold: UIFont {
        UIFont(descriptor: util.fontDescriptor.withSymbolicTraits(.traitBold)!, size: 0)
    }

    /// SwifterSwift: Font as italic font
    var italic: UIFont {
        UIFont(descriptor: util.fontDescriptor.withSymbolicTraits(.traitItalic)!, size: 0)
    }

    /// 平方字体的类型
    private enum PingFangFontType: String {
        case regular = "PingFangSC-Regular"
        case ultralight = "PingFangSC-Ultralight"
        case thin = "PingFangSC-Thin"
        case light = "PingFangSC-Light"
        case medium = "PingFangSC-Medium"
        case semibold = "PingFangSC-Semibold"
        case bold = "PingFangSC-Bold"
    }

    /// 常规体
    static func regular(ofSize size: CGFloat) -> UIFont {
        .init(name: PingFangFontType.regular.rawValue, size: size) ?? .systemFont(ofSize: size)
    }
    
    /// 极细体
    static func ultralight(ofSize size: CGFloat) -> UIFont {
        .init(name: PingFangFontType.ultralight.rawValue, size: size) ?? .systemFont(ofSize: size)
    }
    
    /// 纤细体
    static func thin(ofSize size: CGFloat) -> UIFont {
        .init(name: PingFangFontType.thin.rawValue, size: size) ?? .systemFont(ofSize: size)
    }
    
    /// 细体
    static func light(ofSize size: CGFloat) -> UIFont {
        .init(name: PingFangFontType.light.rawValue, size: size) ?? .systemFont(ofSize: size)
    }

    /// 中黑体
    static func medium(ofSize size: CGFloat) -> UIFont {
        .init(name: PingFangFontType.medium.rawValue, size: size) ?? .systemFont(ofSize: size)
    }

    /// 中粗体
    static func semibold(ofSize size: CGFloat) -> UIFont {
        .init(name: PingFangFontType.semibold.rawValue, size: size) ?? .systemFont(ofSize: size)
    }

    /// 系统粗体
    static func bold(ofSize size: CGFloat) -> UIFont {
        .boldSystemFont(ofSize: size)
    }
}
