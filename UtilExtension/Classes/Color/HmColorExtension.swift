//
//  HmColorExtension.swift
//  SwiftUtil
//
//  Created by mfhj-dz-001-059 on 2021/5/7.
//

#if os(iOS)
import UIKit

public extension HmUtils where Util == UIColor {
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
        var hexFormatted: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()

        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }

        if hexFormatted.hasPrefix("0X") {
            hexFormatted = String(hexFormatted.dropFirst(2))
        }

//        assert(hexFormatted.count == 6, "Invalid hex code used.")
        guard hexFormatted.count == 6 else { return UIColor(white: 0, alpha: 0) }

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
    static func rgb(_ red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1.0) -> UIColor {
        UIColor(red: red / 255.0,
                green: green / 255.0,
                blue: blue / 255.0,
                alpha: alpha)
    }

    /// 转换纯色图片
    func asImage(_ size: CGSize? = CGSize(width: 1, height: 1)) -> UIImage? {
        var resultImage: UIImage?
        let rect = CGRect(x: 0, y: 0, width: size!.width, height: size!.height)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, UIScreen.main.scale)
        guard let context = UIGraphicsGetCurrentContext() else {
            return resultImage
        }
        context.setFillColor(util.cgColor)
        context.fill(rect)
        resultImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resultImage
    }

    /// 设置颜色透明度
    func alpha(_ alpha: CGFloat) -> UIColor {
        util.withAlphaComponent(alpha)
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
#endif
