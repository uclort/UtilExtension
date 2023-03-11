//
//  UtilColorExtension.swift
//  UtilExtension
//
//  Created by 侯猛 on 2022/8/6.
//

import Foundation

public extension UclortExtensionVariableUtil where Util == UIColor {
    /// 随机颜色
    static var randomColor: UIColor {
        let red = CGFloat(arc4random() % 256) / 255.0
        let green = CGFloat(arc4random() % 256) / 255.0
        let blue = CGFloat(arc4random() % 256) / 255.0
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    /// 返回对应的 rgb 色值
    var rgbComponents: (red: Int, green: Int, blue: Int) {
        var components: [CGFloat] {
            let comps = util.cgColor.components!
            if comps.count == 4 { return comps }
            return [comps[0], comps[0], comps[0], comps[1]]
        }
        let red = components[0]
        let green = components[1]
        let blue = components[2]
        return (red: Int(red * 255.0), green: Int(green * 255.0), blue: Int(blue * 255.0))
    }

    /// 通过 16 进制数值创建颜色
    static func hex(_ hexadecimal: UInt32, alpha: CGFloat = 1.0) -> UIColor {
        UIColor(red: CGFloat((hexadecimal & 0xFF0000) >> 16) / 255.0,
                green: CGFloat((hexadecimal & 0x00FF00) >> 8) / 255.0,
                blue: CGFloat(hexadecimal & 0x0000FF) / 255.0,
                alpha: alpha)
    }

    /// 通过 16 进制字符串创建颜色
    static func hexString(_ hexString: String, alpha: CGFloat = 1.0) -> UIColor {
        var hexFormatted: String = hexString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        while hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }

        while hexFormatted.hasPrefix("0X") {
            hexFormatted = String(hexFormatted.dropFirst(2))
        }

        guard hexFormatted.count == 6 else { return .clear }

        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
    }

    /// 通过 rgb 色值创建颜色
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1.0) -> UIColor {
        UIColor(red: red / 255.0,
                green: green / 255.0,
                blue: blue / 255.0,
                alpha: alpha)
    }
    
    /// 转为纯色图片
    /// - Parameters:
    ///   - size: 图片尺寸
    ///   - radius: 图片圆角半径
    func asImage(_ size: CGSize = CGSize(width: 1, height: 1), radius: CGFloat = 0.0) -> UIImage? {
        UIImage.util.create(color: util, size: size, radius: radius)
    }

    /// 设置颜色透明度
    func alpha(_ offset: CGFloat) -> UIColor {
        util.withAlphaComponent(offset)
    }

    /// 转成 16 进制字符串
    func toHexString() -> String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        util.getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb = Int(r * 255)<<16 | Int(g * 255)<<8 | Int(b * 255)<<0
        return String(format: "#%06x", rgb)
    }
}

public extension UclortExtensionVariableUtil where Util == UIColor {
    /// 主题色 3D3D3D
    static var themeColor: UIColor {
        hex(0x3D3D3D)
    }

    /// 导航栏底部边线颜色 4C4C4C
    static var navigationBarBottomLineColor: UIColor {
        hex(0x4C4C4C)
    }

    /// 文字颜色 33333
    static var textColor: UIColor {
        hex(0x333333)
    }
}
