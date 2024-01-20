//
//  HmImageExtension.swift
//  Pods
//
//  Created by 侯猛 on 2022/8/25.
//

import Foundation

public extension HmUtils where Util == UIImage {
    func alpha(_ offset: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(util.size, false, util.scale)
        util.draw(at: .zero, blendMode: .normal, alpha: offset)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    /// 宽高比
    /// 宽:高
    var aspectRatio: CGFloat {
        util.size.width / util.size.height
    }
    
    /// 改变图片尺寸
    /// - Parameter size: 新的尺寸
    /// - Returns: 改变尺寸后的新图片
    func changeSize(to size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        util.draw(in: .init(x: 0, y: 0, width: size.width, height: size.height))
        guard let newImage = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return newImage
    }
    
    /// 改变图片宽度
    /// - Parameters:
    ///   - width: 新的图片宽度
    ///   - keepHeight: 是否保持高度不变
    ///     true: 高度保持不变
    ///     false: 根据原图宽高比在新宽度的基础上对高度进行增减
    /// - Returns: 新图片
    func changeWidth(to width: CGFloat, keepHeight: Bool = false) -> UIImage? {
        let height = keepHeight ? util.size.height : (width / aspectRatio)
        return changeSize(to: .init(width: width, height: height))
    }
    
    /// 改变图片高度
    /// - Parameters:
    ///   - height: 新的图片高度
    ///   - keepWidth: 是否保持高度不变
    ///     true: 宽度保持不变
    ///     false: 根据原图宽高比在新高度的基础上对宽度进行增减
    /// - Returns: 新图片
    func changeHeight(to height: CGFloat, keepWidth: Bool = false) -> UIImage? {
        let width = keepWidth ? util.size.width : (height * aspectRatio)
        return changeSize(to: .init(width: width, height: height))
    }
    
    /// 宽高等比例缩放
    /// - Parameter scale: 缩放比例
    /// - Returns: 改变后的新图片
    func scaleZoom(to scale: CGFloat) -> UIImage? {
        let newSize = CGSize(width: util.size.width * scale, height: util.size.height * scale)
        return changeSize(to: newSize)
    }
}
