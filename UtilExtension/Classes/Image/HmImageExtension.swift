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

    /**
     *  重设图片大小
     */
    func changeSize(to size: CGSize) -> UIImage? {
        // UIGraphicsBeginImageContext(reSize);
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        util.draw(in: .init(x: 0, y: 0, width: size.width, height: size.height))
        guard let reSizeImage = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return reSizeImage
    }

    /**
     *  等比率缩放
     */
    func scaleImage(to scale: CGFloat) -> UIImage? {
        let newSize = CGSize(width: util.size.width * scale, height: util.size.height * scale)
        return changeSize(to: newSize)
    }
}
