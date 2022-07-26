//
//  HmColorExtension.swift
//  SwiftUtil
//
//  Created by mfhj-dz-001-059 on 2021/5/7.
//

#if os(iOS)
import UIKit

public extension UIColor { // init
    convenience init(_ hexString: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }
        
        assert(hexFormatted.count == 6, "Invalid hex code used.")
        
        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)
        
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: alpha)
    }
    
    convenience init(_ hexadecimal: UInt32, alpha: CGFloat = 1.0) {
        self.init(red: CGFloat((hexadecimal & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((hexadecimal & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(hexadecimal & 0x0000FF) / 255.0,
                  alpha: alpha)
    }
}

public extension HmUtils where Util == UIColor {
    static var randomColor: UIColor {
        let red = CGFloat(arc4random() % 256) / 255.0
        let green = CGFloat(arc4random() % 256) / 255.0
        let blue = CGFloat(arc4random() % 256) / 255.0
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
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
    
    func alpha(_ alpha: CGFloat) -> UIColor {
        util.withAlphaComponent(alpha)
    }
    
    func toHexString() -> String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        util.getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb = Int(r*255)<<16 | Int(g*255)<<8 | Int(b*255)<<0
        return String(format: "#%06x", rgb)
    }
}
#endif
