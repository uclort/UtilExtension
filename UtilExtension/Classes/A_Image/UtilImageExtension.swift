//
//  UtilImageExtension.swift
//  UtilExtension
//
//  Created by 侯猛 on 2022/8/6.
//

import Foundation

public enum PKGradientDirection {
    /// 水平 从左到右
    case horizontal
    /// 垂直 从上到下
    case vertical
    /// 左上到右下
    case leftTopRightBottom
    /// 左下到右上
    case leftBottomRightTop
    /// 自定义
    case custom(startPoint: CGPoint, endPoint: CGPoint)

    func imagePoint(size: CGSize) -> (startPoint: CGPoint, endPoint: CGPoint) {
        switch self {
        case .horizontal:
            return (CGPoint(x: 0, y: 0), CGPoint(x: size.width, y: 0))
        case .vertical:
            return (CGPoint(x: 0, y: 0), CGPoint(x: 0, y: size.height))
        case .leftTopRightBottom:
            return (CGPoint(x: 0, y: 0), CGPoint(x: size.width, y: size.height))
        case .leftBottomRightTop:
            return (CGPoint(x: 0, y: size.height), CGPoint(x: size.width, y: 0))
        case let .custom(startPoint, endPoint):
            return (startPoint, endPoint)
        }
    }

    func viewPoint(size: CGSize) -> (startPoint: CGPoint, endPoint: CGPoint) {
        switch self {
        case .horizontal:
            return (CGPoint(x: 0, y: 0), CGPoint(x: 1, y: 0))
        case .vertical:
            return (CGPoint(x: 0, y: 0), CGPoint(x: 0, y: 1))
        case .leftTopRightBottom:
            return (CGPoint(x: 0, y: 0), CGPoint(x: 1, y: 1))
        case .leftBottomRightTop:
            return (CGPoint(x: 0, y: 1), CGPoint(x: 1, y: 0))
        case let .custom(startPoint, endPoint):
            return (startPoint, endPoint)
        }
    }
}

public extension UclortExtensionVariableUtil where Util == UIImage {
    
    /// 创建一张纯色图片
    /// - Parameters:
    ///   - color: 颜色
    ///   - size: 尺寸
    ///   - radius: 圆角半径
    ///
    static func create(
        color: UIColor,
        size: CGSize = .init(width: 1, height: 1),
        radius: CGFloat = 0.0
    ) -> UIImage? {
        defer {
            UIGraphicsEndImageContext()
        }
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.util.scale)
        color.setFill()
        UIRectFill(CGRect(origin: .zero, size: size))
        guard let aCgImage = UIGraphicsGetImageFromCurrentImageContext()?.cgImage else {
            return nil
        }
        return UIImage(cgImage: aCgImage).util.roundedCornerHandler(radius: radius)
    }

    /// 进行圆角处理
    /// - Parameter radius: 圆角半径
    func roundedCornerHandler(radius: CGFloat) -> UIImage {
        guard radius > 0.0 else { return util }
        let radius = UIScreen.util.scale * radius
        defer {
            UIGraphicsEndImageContext()
        }
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: util.size.width, height: util.size.height), cornerRadius: radius)
        UIGraphicsBeginImageContextWithOptions(util.size, false, UIScreen.util.scale)
        let ctx = UIGraphicsGetCurrentContext()
        let rect = CGRect(x: 0, y: 0, width: util.size.width, height: util.size.height)
        ctx?.addPath(path.cgPath)
        ctx?.clip()
        util.draw(in: rect)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            return util
        }
        UIGraphicsEndImageContext()
        return image
    }

    /// 图片字节大小
    var bytesSize: Int {
        util.jpegData(compressionQuality: 1)?.count ?? 0
    }

    /// 图片千字节大小
    var kilobytesSize: Int {
        (util.jpegData(compressionQuality: 1)?.count ?? 0) / 1024
    }

    /// 原始图
    var original: UIImage {
        util.withRenderingMode(.alwaysOriginal)
    }

    /// 模型图
    var template: UIImage {
        util.withRenderingMode(.alwaysTemplate)
    }

    /// SwifterSwift: UIImage tinted with color
    ///
    /// - Parameters:
    ///   - color: color to tint image with.2
    ///   - blendMode: how to blend the tint
    /// - Returns: UIImage tinted with given color.
    func tint(_ color: UIColor, blendMode: CGBlendMode, alpha: CGFloat = 1.0) -> UIImage {
        let drawRect = CGRect(origin: .zero, size: util.size)

        #if !os(watchOS)
            if #available(tvOS 10.0, *) {
                let format = UIGraphicsImageRendererFormat()
                format.scale = util.scale
                return UIGraphicsImageRenderer(size: util.size, format: format).image { context in
                    color.setFill()
                    context.fill(drawRect)
                    util.draw(in: drawRect, blendMode: blendMode, alpha: alpha)
                }
            }
        #endif

        UIGraphicsBeginImageContextWithOptions(util.size, false, util.scale)
        defer {
            UIGraphicsEndImageContext()
        }
        let context = UIGraphicsGetCurrentContext()
        color.setFill()
        context?.fill(drawRect)
        util.draw(in: drawRect, blendMode: blendMode, alpha: alpha)
        return UIGraphicsGetImageFromCurrentImageContext()!
    }

    /// 调整图片透明度
    /// - Parameter offset: 透明值
    /// - Returns: 新的图片
    func alpha(_ value: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(util.size, false, util.scale)
        util.draw(at: .zero, blendMode: .normal, alpha: value)
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
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.util.scale)
        util.draw(in: .init(x: 0, y: 0, width: size.width, height: size.height))
        guard let newImage = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return newImage
    }

    /// 改变图片宽度
    /// - Parameters:
    ///   - width: 新的图片宽度
    ///   - keepHeight: 是否保持高度不变 默认 false
    ///     true: 高度保持不变
    ///     false: 根据原图宽高比在新宽度的基础上对高度进行增减
    /// - Returns: 新图片
    func changeWidth(to width: CGFloat, keepHeight: Bool = false) -> UIImage? {
        changeSize(
            to: .init(
                width: width,
                height: keepHeight ? util.size.height : (width / aspectRatio)
            )
        )
    }

    /// 改变图片高度
    /// - Parameters:
    ///   - height: 新的图片高度
    ///   - keepWidth: 是否保持高度不变 默认 false
    ///     true: 宽度保持不变
    ///     false: 根据原图宽高比在新高度的基础上对宽度进行增减
    /// - Returns: 新图片
    func changeHeight(to height: CGFloat, keepWidth: Bool = false) -> UIImage? {
        changeSize(
            to: .init(
                width: keepWidth ? util.size.width : (height * aspectRatio),
                height: height
            )
        )
    }

    /// 宽高等比例缩放
    /// - Parameter scale: 缩放比例
    /// - Returns: 改变后的新图片
    func scaleZoom(to scale: CGFloat) -> UIImage? {
        changeSize(
            to: .init(
                width: util.size.width * scale,
                height: util.size.height * scale
            )
        )
    }

    /// 获取在富文本中垂直居中的顶部坐标
    /// - Parameters:
    ///   - font: 富文本字体
    ///   - height: 富文本中图片高度 不传或传 nil 默认使用图片自身高度
    /// - Returns: 顶部高度
    func getAttributedVerticalCenterTop(font: UIFont, height: CGFloat? = nil) -> CGFloat {
        let height = height.utilOr(for: util.size.height)
        let mid = font.descender + font.capHeight
        return font.descender - height / 2.0 + mid + 2.0
    }

    /// 生成渐变色图片
    /// - Parameters:
    ///   - colors: UIColor 数组
    ///   - size: 图片尺寸 非必传
    ///       - 默认 width = height = 1
    ///   - radius: 图片圆角 非必传
    ///       - 默认值 0 不设置圆角
    ///   - locations: locations 数组 非必传
    ///       - 必须和 colors 数量保持一致
    ///       - 每个 location 对应每个颜色的渐变起始点
    ///       - 意义不清楚可以不传或者传 nil
    ///   - direction: 渐变的方向
    ///       - 默认水平
    /// - Returns: 带圆角的渐变的图片
    static func gradient(
        for colors: [UIColor],
        size: CGSize = CGSize(width: 1, height: 1),
        radius: CGFloat = 0,
        locations: [Double]? = nil,
        direction: PKGradientDirection = .horizontal
    ) -> UIImage? {
        if colors.count == 0 { return nil }
        if colors.count == 1, let color = colors.first {
            return create(color: color)
        }
        var locationsGroup: [Double] = []
        if let locations {
            locationsGroup = locations
        } else {
            let locationIncrementalValue = 1.0 / Double(colors.count - 1)
            for index in 0 ..< colors.count {
                locationsGroup.append(Double(index) * locationIncrementalValue)
            }
            locationsGroup.removeLast()
            locationsGroup.append(1.0)
        }

        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.util.scale)
        let context = UIGraphicsGetCurrentContext()
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: size.width, height: size.height), cornerRadius: radius)
        path.addClip()
        context?.addPath(path.cgPath)
        guard let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: colors.map { $0.cgColor } as CFArray, locations: locationsGroup.map { CGFloat($0) }) else { return nil }
        let directionPoint = direction.imagePoint(size: size)
        context?.drawLinearGradient(gradient, start: directionPoint.0, end: directionPoint.1, options: .drawsBeforeStartLocation)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

public extension UclortExtensionVariableUtil where Util == UIImage {
    /// 获取 target 所在模块下图片
    /// - Parameters:
    ///   - named: 图片名称
    ///   - target: 所需模块图片中的对象 可选
    ///   - otherModuleName: 模块名称 可选
    ///   - otherBundleName: 资源库名称 可选 优先级最高
    static func get(
        named: String,
        target: NSObject? = nil,
        otherModuleName: String? = nil,
        otherBundleName: String? = nil
    ) -> UIImage? {
        UIImage(named: named, in: Bundle.util.create(for: target, otherModuleName: otherModuleName, otherBundleName: otherBundleName), compatibleWith: nil)
    }

    /// 获取 target 所在模块下图片
    /// - Parameters:
    ///   - named: 图片名称
    ///   - target: Bundle 所在模块下的对象
    ///   - bundleName: 资源库名称 可选 优先级最高
    static func get(
        named: String,
        for target: NSObject,
        bundleName: String? = nil
    ) -> UIImage? {
        get(named: named, target: target, otherBundleName: bundleName)
    }

    /// 根据模块和资源库名称获取图片
    /// - Parameters:
    ///   - named: 图片名称
    ///   - moduleName: 模块名称
    ///   - bundleName: 资源库名称
    static func get(
        named: String,
        moduleName: String,
        bundleName: String
    ) -> UIImage? {
        get(named: named, otherModuleName: moduleName, otherBundleName: bundleName)
    }
    

    /// 根据模块资源库名称获取图片
    /// - Parameters:
    ///   - named: 图片名称
    ///   - moduleBundleName: 模块资源名称
    static func get(
        named: String,
        moduleBundleName: String
    ) -> UIImage? {
        get(named: named, otherModuleName: moduleBundleName, otherBundleName: moduleBundleName)
    }
}

public extension UclortExtensionVariableUtil where Util == UIImage {
    private static func getImage(named: String) -> UIImage? {
        get(named: named, otherModuleName: "BaseExtension", otherBundleName: "PickResources")
    }

    static var blackBackImage: UIImage? {
        getImage(named: "blackBackImage")
    }

    static var whiteBackImage: UIImage? {
        getImage(named: "whiteBackImage")
    }

    static var loadDataFaild: UIImage? {
        getImage(named: "loadDataFaild")
    }

    static var noDataImage: UIImage? {
        getImage(named: "noDataImage")
    }

    static var noNetImage: UIImage? {
        getImage(named: "noNetImage")
    }

    static var vipLevel1: UIImage? {
        getImage(named: "vip_level_1")
    }

    static var vipLevel2: UIImage? {
        getImage(named: "vip_level_2")
    }

    static var vipLevel3: UIImage? {
        getImage(named: "vip_level_3")
    }

    static var vipLevel4: UIImage? {
        getImage(named: "vip_level_4")
    }

    static var vipLevel5: UIImage? {
        getImage(named: "vip_level_5")
    }

    static var vipLevel6: UIImage? {
        getImage(named: "vip_level_6")
    }

    static func getVipLevelImage(level: String?) -> UIImage? {
        guard let level = level else {
            return vipLevel1
        }
        return getImage(named: "vip_level_\(level)") ?? vipLevel1
    }
}
